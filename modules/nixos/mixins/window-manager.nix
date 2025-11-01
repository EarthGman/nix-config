{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gman.window-manager;
in
{
  options.gman.window-manager = {
    enable = lib.mkEnableOption "gman's configuration for DIY window managers";
  };

  config = lib.mkIf cfg.enable {
    programs = {
      # pipewire control dashboard
      pwvucontrol.enable = lib.mkDefault true;
      # pdf viewer
      evince.enable = lib.mkDefault true;
      # image viewer
      gthumb.enable = lib.mkDefault true;
      # graphical file manager
      dolphin.enable = lib.mkDefault true;

      gnome-calculator.enable = lib.mkDefault true;
      # gtk themer
      nwg-look.enable = lib.mkDefault true;
    };
    xdg.portal = {
      enable = true;
      # require all xdg-open commands to use the portal
      xdgOpenUsePortal = lib.mkDefault true;
    };
    services.nm-applet.enable = lib.mkDefault true;
  };
}
