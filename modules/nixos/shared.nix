{ inputs, outputs, pkgs, lib, config, hostName, cpu, vm, platform, stateVersion, ... }:
let
  inherit (lib) mkDefault mkIf mkForce getExe optionalString;
in
{
  # use disko disk paritioning scheme for all machines
  imports = [ inputs.disko.nixosModules.disko ];

  # default profile for all machines
  modules = {
    ssh.enable = mkDefault true;
    nh.enable = mkDefault true;
    neovim.enable = mkDefault true;
  };
  # goodbye bloat
  documentation.nixos.enable = mkDefault false;

  # other module boilerplate, applied by default to all configurations
  users.users."root".shell = pkgs.zsh;
  users.mutableUsers = mkDefault false;

  hardware = {
    enableRedistributableFirmware = mkDefault true;
    cpu.${cpu}.updateMicrocode = mkIf (vm == "no")
      (mkDefault config.hardware.enableRedistributableFirmware);
  };

  boot = {
    kernelPackages = mkDefault pkgs.linuxPackages_latest;
  };

  networking = {
    # forces wireless off since I use networkmanager for all systems
    wireless.enable = mkForce false;
    inherit hostName;
    networkmanager.enable = true;
  };

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };
  nixpkgs = {
    overlays = (builtins.attrValues outputs.overlays);
    config.allowUnfree = true;
    hostPlatform = platform;
  };

  time.timeZone = mkDefault "America/Chicago";
  system = {
    inherit stateVersion;
  };

  environment.systemPackages =
    let
      remote-build = pkgs.writeScriptBin "remote-build" ''
        hostnames=(server-corekeeper server-mc112 server-mc121 server-mc-blueprints)
        hostname=$(printf "%s\n" "''${hostnames[@]}" | fzf)
        pushd /etc/nixos
        nixos-rebuild switch --flake ".#$hostname" --target-host $hostname --use-remote-sudo
        popd
      '';
    in
    with pkgs; [
      btop
      powertop
      fzf
      sysz
      git
      file
      cifs-utils
      ncdu
      hstr
      inxi
      killall
      pamixer
      brightnessctl
      zip
      unzip
      usbutils
      pciutils
      lshw
      lsof
      fd
      lynx
      ripgrep
      zoxide # must be on path
      remote-build
    ];

  # root level shell
  programs.zsh = {
    enable = true;
    shellAliases =
      let
        has-nh = config.programs.nh.enable;
      in
      {
        l = "ls -al";
        g = "${getExe pkgs.git}";
        t = "${getExe pkgs.tree}";
        ga = "g add .";
        gco = "g checkout";
        gba = "g branch -a";
        cat = "${getExe pkgs.bat}";
        nrs = if (has-nh) then "${getExe pkgs.nh} os switch $(readlink -f /etc/nixos)" else "sudo nixos-rebuild switch --flake $(readlink -f /etc/nixos)";
        nrt = if (has-nh) then "${getExe pkgs.nh} os test $(readlink -f /etc/nixos)" else "sudo nixos-rebuild test --flake $(readlink -f /etc/nixos)";
        nrb = "nixos-rebuild build";
        ncg = if (has-nh) then "${getExe pkgs.nh} clean all" else "sudo nix-collect-garbage -d";
      };

    promptInit =
      let
        has-neovim = config.modules.neovim.enable;
      in
      ''
        eval "$(${getExe pkgs.zoxide} init --cmd j zsh)"
      '' + optionalString (has-neovim) ''
        export EDITOR=nvim
      '' + optionalString (!(has-neovim)) ''
        export EDITOR=nano
      '';
  };
  # enable starship for everyone
  programs.starship.enable = mkDefault true;
}
