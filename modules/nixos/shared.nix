{ inputs, outputs, pkgs, users, lib, config, hostName, cpu, vm, platform, stateVersion, ... }:
let
  inherit (lib) mkDefault mkIf optionals mkForce getExe optionalString;
in
{
  imports = [
    inputs.disko.nixosModules.disko
  ];

  # default profile for all machines
  modules = {
    home-manager.enable = mkDefault users != [ ];
    ssh.enable = mkDefault true;
    nh.enable = mkDefault true;
    neovim.enable = mkDefault true;
  };

  programs = {
    yazi.enable = mkDefault true;
    direnv = {
      enable = mkDefault true;
      nix-direnv.enable = true;
    };
  };

  # goodbye bloat
  documentation.nixos.enable = mkDefault false;

  # other module boilerplate, applied by default to all configurations
  users.users."root".shell = pkgs.zsh;
  users.mutableUsers = mkDefault false;

  hardware = {
    enableRedistributableFirmware = mkDefault true;
    cpu.${cpu}.updateMicrocode = mkIf (!vm)
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
        hostnames=(mc112 mc121 mc-blueprints wireguard)
        hostname=$(printf "%s\n" "''${hostnames[@]}" | fzf)
        pushd /etc/nixos
        nixos-rebuild switch --flake ".#$hostname" --target-host $hostname --use-remote-sudo
        popd
      '';
    in
    with pkgs; [
      btop
      busybox
      efibootmgr
      dig
      powertop
      fzf
      sysz
      git
      file
      cifs-utils
      ncdu
      nix-prefetch-git
      hstr
      inxi
      killall
      zip
      unzip
      usbutils
      pciutils
      lshw
      lsof
      fd
      jq
      lynx
      tcpdump
      ripgrep
      zoxide # must be on path
      remote-build
    ]
    ++ optionals (config.services.keyd.enable) [
      # idk why services.keyd.enable doesn't install this cli
      pkgs.keyd
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
        setopt autocd
      '' + optionalString (has-neovim) ''
        export EDITOR=nvim
      '' + optionalString (!(has-neovim)) ''
        export EDITOR=nano
      '' + optionalString (config.programs.yazi.enable) ''
         function y() {
         local tmp="$(mktemp -t "yazi-cwd.XXXXX")"
         yazi "$@" --cwd-file="$tmp"
         if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
           builtin cd -- "$cwd"
         fi
         rm -f -- "$tmp"
        }
      '';
  };
  # enable starship for everyone
  programs.starship.enable = mkDefault true;
}
