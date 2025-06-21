{ pkgs, config, lib, ... }:
let
  inherit (lib) mkDefault mkOverride mkEnableOption mkIf;
  cfg = config.profiles.server.default;
in
{
  options.profiles.server.default.enable = mkEnableOption "default server profile";
  config = mkIf cfg.enable {

    # debloat
    environment.defaultPackages = [ ];
    #boot.initrd.includeDefaultModules = false;
    hardware.enableRedistributableFirmware = false;

    # make sure clean doesn't leave any unnecessary nixos configurations
    programs = {
      git.enable = mkOverride 800 false;
      lazygit.enable = mkOverride 800 false;
      nh.enable = mkOverride 800 false;
      neovim-custom = {
        package = mkDefault pkgs.nvim-lite;
      };
      vim = {
        # srvos assumes im using vim instead of neovim
        enable = false;
        defaultEditor = false;
      };
      nh = {
        clean.extraArgs = "--keep-since 1d --keep 1";
      };
    };

    # use systemd boot, less bloated than grub
    modules.bootloaders.systemd-boot.enable = mkDefault true;
  };
}
