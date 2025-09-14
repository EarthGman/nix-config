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
    # mixins revelent for desktop
    gman = {
      pipewire.enable = lib.mkDefault true;
      bluetooth.enable = lib.mkDefault true;
      printing.enable = lib.mkDefault true;
      stylix.enable = lib.mkDefault true;

      # which desktop to enable
      hyprland.enable = (config.meta.desktop == "hyprland");
      sway.enable = (config.meta.desktop == "sway");
      gnome.enable = (config.meta.desktop == "gnome");

      hardware-tools.enable = lib.mkDefault true;
    };

    # additional boilerplate
    boot = {
      extraModulePackages = [
        # for obs virtual camera
        # config.boot.kernelPackages.v4l2loopback
      ];
    };

    services.flatpak.enable = true;
    # flatpak frontend
    programs.gnome-software.enable = true;
    systemd.services.flatpak-repo = {
      wantedBy = [ "multi-user.target" ];
      path = [ pkgs.flatpak ];
      script = ''
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
      '';
    };

    hardware.graphics = {
      enable = true;
      enable32Bit = lib.mkDefault true;
    };

    # mounting network drives in file managers (specifically nautilus)
    services.gvfs.enable = lib.mkDefault true;

    # setup a display manager
    services.displayManager.sddm.enable = lib.mkDefault true;

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

    security.polkit.enable = lib.mkDefault true; # graphical prompt for sudo

    qt = {
      enable = lib.mkDefault true;
      # platformTheme = lib.mkDefault "gnome";
      # style = mkDefault "adwaita-dark";
    };

    # required for some stylix to work properly (gtk)
    programs.dconf.enable = lib.mkDefault true;
  };
}
