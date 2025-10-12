# not to be interpreted as "desktop PC" but module for any machine that has a desktop environment
{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gman.desktop;
in
{
  options.gman.desktop.enable = lib.mkEnableOption "gman's configuration for hosts with a desktop environment";
  config = lib.mkIf cfg.enable {
    # configuration revelent for desktop
    gman = {
      # sound
      pipewire.enable = lib.mkDefault true;
      bluetooth.enable = lib.mkDefault true;

      # common printing configuration
      printing.enable = lib.mkDefault true;

      # desktop stylization
      stylix.enable = lib.mkDefault true;
      desktop-theme-sync.enable = lib.mkDefault true;

      # imperative applications for ease of install
      flatpak.enable = lib.mkDefault true;

      # which desktop to enable
      hyprland.enable = (config.meta.desktop == "hyprland");
      sway.enable = (config.meta.desktop == "sway");
      gnome.enable = (config.meta.desktop == "gnome");
      plasma.enable = (config.meta.desktop == "plasma");

      hardware-tools.enable = lib.mkDefault true;
    };

    # additional boilerplate
    boot = {
      extraModulePackages = [
        # for obs virtual camera
        config.boot.kernelPackages.v4l2loopback
      ];
    };

    # kind of redundant, but good to have.
    hardware.graphics = {
      enable = true;
      enable32Bit = lib.mkDefault true;
    };

    # mounting network drives in file managers
    services.gvfs.enable = lib.mkDefault true;

    # use sddm as default display manager, will change to gdm if gnome is the desktop
    services.displayManager.sddm.enable = lib.mkDefault true;

    # ensure xserver configuration is applied
    services.xserver = {
      enable = lib.mkDefault true;
      excludePackages = builtins.attrValues {
        inherit (pkgs)
          xterm
          ;
      };
    };

    # sets up a default desktop portal backend
    xdg.portal = {
      enable = lib.mkDefault true;
      extraPortals = lib.mkDefault [ pkgs.xdg-desktop-portal ];
      xdgOpenUsePortal = true;
    };

    # graphical prompt for sudo
    security.polkit.enable = lib.mkDefault true;

    qt = {
      enable = lib.mkDefault true;
    };

    # required for some stylix modules to style gtk apps
    programs.dconf.enable = lib.mkDefault true;
  };
}
