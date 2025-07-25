# not to be interpreted as "desktop PC" but module for any machine that has a desktop environment
{
  pkgs,
  lib,
  config,
  ...
}@args:
let
  users = if args ? users then args.users else [ ];
  inherit (lib) mkDefault optionals;
  enabled = {
    enable = mkDefault true;
  };
  inherit (lib) mkEnableOption mkIf;
  cfg = config.modules.desktop;
in
{
  options.modules.desktop.enable = mkEnableOption "desktop module";
  config = mkIf cfg.enable {
    boot = {
      extraModulePackages = [
        # for obs virtual camera
        config.boot.kernelPackages.v4l2loopback
      ];
    };
    hardware.graphics = {
      enable = true;
      enable32Bit = mkDefault true;
    };

    # mounting network drives in file managers
    services.gvfs.enable = mkDefault true;

    # setup a display manager
    services.displayManager.sddm.enable = mkDefault true;

    services.xserver = {
      enable = mkDefault true;
      xkb.layout = mkDefault "us";
      excludePackages = with pkgs; [ xterm ];
    };

    # sets up a default desktop portal backend
    xdg.portal = {
      enable = mkDefault true;
      extraPortals = mkDefault [ pkgs.xdg-desktop-portal ];
      xdgOpenUsePortal = true;
    };

    security.polkit.enable = mkDefault true; # graphical prompt for sudo

    qt = {
      enable = mkDefault true;
      platformTheme = mkDefault "gnome";
      style = mkDefault "adwaita-dark";
    };

    # some features most desktops would probably want
    modules = {
      home-manager.enable = mkDefault users != [ ];
      system-stylizer.enable = mkDefault true;
      pipewire = enabled;
      bluetooth = enabled;
      printing = enabled;
      bootloaders.grub = enabled;
    };

    environment.systemPackages =
      with pkgs;
      [
        brightnessctl # brightness
      ]
      ++ optionals (config.modules.pipewire.enable) [
        pamixer
      ]
      ++ optionals (config.services.xserver.enable) [
        xorg.xhost
      ];

    # required for some stylix to work properly (gtk)
    programs.dconf.enable = mkDefault true;
  };
}
