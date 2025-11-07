{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gman.desktop.niri;
in
{
  options.gman.desktop.niri = {
    enable = lib.mkEnableOption "gman's niri configuration";
  };

  config = lib.mkIf cfg.enable {
    # install the needed stuff
    programs = {
      # niri module already enables gnome keyring daemon
      niri = {
        enable = true;
      };
      # the systemd unit this option provides is broken
      # essentially it does not provide the proper environment for all components to work properly
      # waybar.enable = true;

      # default terminal for niri
      alacritty.enable = lib.mkDefault true;
    };

    services = {
      batsignal.enable = lib.mkDefault true;
      swaync.enable = lib.mkDefault true;
      kde-polkit-agent.enable = lib.mkDefault true;
      awww = {
        enable = true;
        flags = lib.mkDefault [
          "-f"
          "argb"
        ];
      };
    };

    environment = {
      # add network manager applet schemas to XDG_DATA_DIRS
      # services.nm-applet.enable is not needed since it is provded by niri but the DATA DIRS path still needs to be set to render icons
      profiles = [ "${pkgs.networkmanagerapplet}" ];

      systemPackages = builtins.attrValues {
        inherit (pkgs)
          waybar
          libnotify # provides `notify-send`
          wl-clipboard
          grim # screenshots
          slurp # screen selector
          swaylock # lockscreen
          swayidle # daemonless swayidle
          # setup xwayland support for niri
          xwayland-satellite
          ;
      };
    };

    # global xdg portal configuration
    # uses wlr as primary with gtk as a fallback
    xdg.portal = {
      wlr.enable = true;
      config.niri = {
        default = [
          "wlr"
          "gtk"
        ];
        # prevent nautilus from auto installing itself
        "org.freedesktop.impl.portal.FileChooser" = "gtk";
      };
    };
  };
}
