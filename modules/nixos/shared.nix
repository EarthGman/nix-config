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
    tmux.enable = mkDefault true;
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

  nix = {
    channel.enable = mkDefault false; # please just use flakes instead
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
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
      tldr
      lynx
      tcpdump
      ripgrep
      zoxide # must be on path
    ]
    ++ optionals (config.services.keyd.enable) [
      # idk why services.keyd.enable doesn't install this cli
      pkgs.keyd
    ];

  programs.lazygit.enable = mkDefault true;

  # root level shell
  programs.zsh = {
    enable = true;
    enableCompletion = mkDefault true;
    syntaxHighlighting.enable = mkDefault true;
    autosuggestions.enable = mkDefault true;
    shellAliases =
      let
        has-nh = config.programs.nh.enable;
      in
      {
        l = "ls -al";
        g = "${getExe pkgs.git}";
        t = "${getExe pkgs.tree}";
        lg = mkIf (config.programs.lazygit.enable) "${getExe pkgs.lazygit}";
        ga = "g add .";
        gco = "g checkout";
        gba = "g branch -a";
        cat = "${getExe pkgs.bat}";
        nrs = if (has-nh) then "${getExe pkgs.nh} os switch $(readlink -f /etc/nixos)" else "sudo nixos-rebuild switch --flake $(readlink -f /etc/nixos)";
        nrt = if (has-nh) then "${getExe pkgs.nh} os test $(readlink -f /etc/nixos)" else "sudo nixos-rebuild test --flake $(readlink -f /etc/nixos)";
        nrb = "nixos-rebuild build";
        ncg = if (has-nh) then "${getExe pkgs.nh} clean all" else "sudo nix-collect-garbage -d";
      };

    promptInit = ''
      eval "$(${getExe pkgs.zoxide} init --cmd j zsh)"
      setopt autocd
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
