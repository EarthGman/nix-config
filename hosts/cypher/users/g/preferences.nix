{ outputs, wallpapers, ... }:
let
  inherit (builtins) fetchurl;
  theme = outputs.homeProfiles.desktopThemes.celeste;
in
{
  imports = [
    theme
  ];

  programs = {
    dolphin-emu.enable = true;
    lutris.enable = true;
    davinci-resolve.enable = true;
    feh.enable = true;

    looking-glass.enable = true;
    looking-glass.version = "B6";
    obs-studio.enable = true;
    ygo-omega.enable = true;
  };

  services.fehbg = {
    # slideshow = {
    #   enable = true;
    #   images = with wallpapers; [
    #     (fetchurl celeste)
    #     (fetchurl celeste-mountain)
    #   ];
    # };
    settings.monitors = {
      "0" = {
        image = fetchurl wallpapers.celeste-mountain;
      };
      "1" = {
        image = fetchurl wallpapers.celeste;
      };
    };
  };

  # monitors for hyprland
  wayland.windowManager.hyprland.settings.monitor = [
    "DP-3, 2560x1440, 0x0, 1"
    "DP-2, 2560x1440, 0x0, 1"
    "HDMI-A-1, 1920x1080@74.97, -1920x0, 1"
  ];

  # monitors for xorg
  xsession.profileExtra = ''
    xrandr --output DisplayPort-2 --auto --right-of HDMI-A-0 \
           --output DisplayPort-2 --mode 2560x1440 \
           --output HDMI-A-0 --mode 1920x1080 --rate 74.97 \
  '';

  wayland.windowManager.sway.config.output = {
    "DP-3" = {
      scale = "1.0";
      mode = "2560x1440@59.951Hz";
      position = "0,0";
    };
    "HDMI-A-1" = {
      scale = "1.0";
      mode = "1920x1080@100.000Hz";
      position = "-1920,0";
    };
  };
}
