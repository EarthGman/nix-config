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
    cemu.enable = true;
    lutris.enable = true;
    davinci-resolve.enable = true;

    looking-glass.enable = true;
    looking-glass.version = "B6";
    obs-studio.enable = true;
    ygo-omega.enable = true;
    neovim.imperativeLua = true;
  };

  services.swww.monitors = {
    DP-4 = {
      image = fetchurl wallpapers.celeste-mountain;
    };
    HDMI-A-2 = {
      image = fetchurl wallpapers.celeste;
    };
  };

  services.fehbg = {
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
  # wayland.windowManager.hyprland.settings.monitor = [
  #   "DP-3, 2560x1440, 0x0, 1"
  #   "DP-2, 2560x1440, 0x0, 1"
  #   "HDMI-A-1, 1920x1080@74.97, -1920x0, 1"
  # ];

  # kanshi profiles
  services.kanshi = {
    enable = true;
    settings = [
      {
        profile.name = "home";
        profile.outputs = [
          {
            criteria = "LG Electronics LG HDR 4K 0x0007B5B9";
            position = "0,0";
            mode = "2560x1440@59.951Hz";
          }
          {
            criteria = "Sceptre Tech Inc Sceptre F24 0x01010101";
            position = "-1920,0";
            mode = "1920x1080@100Hz";
          }
        ];
      }
      #TODO add school profile when I get back
    ];
  };

  # monitors for xorg
  xsession.profileExtra = ''
    xrandr --output DisplayPort-2 --auto --right-of HDMI-A-0 \
           --output DisplayPort-2 --mode 2560x1440 \
           --output HDMI-A-0 --mode 1920x1080 --rate 74.97 \
  '';

  # monitors for sway
  # wayland.windowManager.sway.config.output = {
  #   "DP-3" = {
  #     scale = "1.0";
  #     mode = "2560x1440@59.951Hz";
  #     position = "0,0";
  #   };
  #   "HDMI-A-1" = {
  #     scale = "1.0";
  #     mode = "1920x1080@100.000Hz";
  #     position = "-1920,0";
  #   };
  # };
}
