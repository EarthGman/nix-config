{ outputs, pkgs, lib, config, ... }:
let
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
    };

    profiles = {
      tmux.default.enable = mkDefault true;
      zsh.default.enable = mkDefault true;
    };

    documentation.nixos.enable = mkDefault false;

    users.users."root".shell = pkgs.zsh;
    users.mutableUsers = mkDefault false;

    hardware.enableRedistributableFirmware = mkDefault true;

    boot.kernelPackages = mkDefault pkgs.linuxPackages_latest;

    networking = {
      wireless.enable = mkForce false;
      networkmanager.enable = true;
    };

    nix = {
      channel.enable = mkDefault false;
      settings = {
        experimental-features = [ "nix-command" "flakes" ];
        auto-optimise-store = mkDefault true;
      };
    };

    nixpkgs = {
      overlays = (builtins.attrValues outputs.overlays);
      config.allowUnfree = true;
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
