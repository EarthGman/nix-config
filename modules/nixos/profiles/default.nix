{ outputs, pkgs, lib, config, ... }@args:
let
  hostName = if args ? hostName then args.hostName else "";
  cpu = if args ? cpu then args.cpu else null;
  vm = if args ? vm then args.vm else false;
  server = if args ? server then args.server else false;
  iso = if args ? iso then args.iso else false;
  desktop = if args ? desktop then args.desktop else null;
  stateVersion = if args ? stateVersion then args.stateVersion else "";
  system = if args ? system then args.system else null;

  inherit (lib) mkIf mkEnableOption mkForce mkDefault autoImport;
  cfg = config.profiles.default;
in
{
  imports = autoImport ./.;

  options.profiles.default.enable = mkEnableOption "default nixos profile";
  config = mkIf cfg.enable {
    modules = {
      direnv.enable = mkDefault true;
      ssh.enable = mkDefault true;
      nh.enable = mkDefault true;

      iso.enable = iso;
      desktop.enable = desktop != null;
      qemu-guest.enable = vm;
    };

    system = mkIf (stateVersion != "") {
      inherit stateVersion;
    };

    profiles = {
      tmux. default. enable = mkDefault true;
      zsh.default.enable = mkDefault true;

      server.default.enable = mkDefault server;
    };

    documentation.nixos.enable = mkDefault false;
    services.dbus.implementation = "broker";

    users.users."root".shell = pkgs.zsh;
    users.mutableUsers = mkDefault false;

    hardware.enableRedistributableFirmware = mkDefault true;

    hardware.cpu.${cpu}.updateMicrocode = mkIf (!vm)
      (mkDefault config.hardware.enableRedistributableFirmware);

    boot.kernelPackages = mkDefault pkgs.linuxPackages_latest;

    networking = {
      wireless.enable = mkForce false;
      networkmanager.enable = true;
      hostName = mkIf (hostName != "") hostName;
    };

    nix = {
      channel.enable = mkDefault false;
      settings = {
        experimental-features = [ "nix-command" "flakes" ];
        auto-optimise-store = mkDefault true;
      };
    };

    nixpkgs = {
      overlays = builtins.attrValues outputs.overlays;
      config.allowUnfree = true;
      hostPlatform = mkIf (system != null) system;
    };

    time.timeZone = mkDefault "America/Chicago";

    environment.systemPackages = with pkgs; [
      btop
      efibootmgr
      powertop
      fzf
      sysz
      file
      cifs-utils
      ncdu
      nix-prefetch-git
      hstr
      inxi
      psmisc
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
      ripgrep
    ];

    programs = {
      yazi.enable = mkDefault true;
      neovim-custom = {
        enable = mkDefault true;
        viAlias = mkDefault true;
        vimAlias = mkDefault true;
        defaultEditor = mkDefault true;
      };
      lazygit.enable = mkDefault true;
      tmux.enable = mkDefault true;
      starship.enable = mkDefault true;
      bat.enable = mkDefault true;
      zoxide = {
        enable = mkDefault true;
        flags = mkDefault [
          "--cmd j"
        ];
      };
    };
  };
}
