{
  pkgs,
  lib,
  config,
  ...
}@args:
let
  hostName = if args ? hostName then args.hostName else "";
  cpu = if args ? cpu then args.cpu else null;
  vm = if args ? vm then args.vm else false;
  server = if args ? server then args.server else false;
  iso = if args ? iso then args.iso else false;
  desktop = if args ? desktop then args.desktop else null;
  stateVersion = if args ? stateVersion then args.stateVersion else "";
  system = if args ? system then args.system else null;

  inherit (lib)
    mkIf
    mkEnableOption
    mkForce
    mkDefault
    autoImport
    ;
  cfg = config.profiles.default;

  nixos-update = pkgs.writeShellScriptBin "nixos-update" ''
    sudo nixos-rebuild switch --flake github:earthgman/nix-config
  '';
in
{
  imports = autoImport ./.;

  options.profiles.default.enable = mkEnableOption "default nixos profile";
  config = mkIf cfg.enable {
    determinate.enable = mkDefault false;
    modules = {
      determinate.enable = mkDefault true;
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
      tmux.default.enable = mkDefault true;
      zsh.default.enable = mkDefault true;
      fzf.default.enable = mkDefault true;
      fish.default.enable = mkDefault true;
      server.default.enable = mkDefault server;
      sddm.default.enable = mkDefault true;

      hardware-tools.enable = mkDefault true;
      cli-tools.enable = mkDefault true;
    };

    documentation.nixos.enable = mkDefault false;
    services.dbus.implementation = "broker";

    users.users."root".shell = pkgs.zsh;
    users.mutableUsers = mkDefault false;

    hardware.enableRedistributableFirmware = mkDefault true;

    hardware.cpu.${cpu}.updateMicrocode = mkIf (!vm) (
      mkDefault config.hardware.enableRedistributableFirmware
    );

    boot = {
      kernelPackages = mkDefault pkgs.linuxPackages_latest;
      tmp.cleanOnBoot = mkDefault true;
    };

    networking = {
      wireless.enable = mkForce false;
      networkmanager.enable = true;
      hostName = mkIf (hostName != "") hostName;
    };

    nix = {
      channel.enable = mkDefault false;
      settings = {
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        auto-optimise-store = mkDefault true;
      };
    };

    nixpkgs = {
      config.allowUnfree = true;
      hostPlatform = mkIf (system != null) system;
    };

    time.timeZone = mkDefault "America/Chicago";

    environment = {

      systemPackages = with pkgs; [
        nixos-update
        file
        psmisc
        zip
        unzip
        lsof
      ];
    };

    programs = {
      yazi.enable = mkDefault true;
      neovim-custom = {
        enable = mkDefault true;
        viAlias = mkDefault true;
        vimAlias = mkDefault true;
        defaultEditor = mkDefault true;
        package = mkDefault pkgs.nvim;
      };
      git.enable = mkDefault true;
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
