{ self, lib, ... }:
let
  theme = self + /profiles/home-manager/desktop-themes/faraway.nix;
in
{
  imports = [
    theme
  ];

  programs = {
    dolphin-emu.enable = true;
    lutris.enable = true;
    davinci-resolve.enable = true;

    looking-glass.enable = true;
    looking-glass.version = "B6";
    obs-studio.enable = true;
    ygo-omega.enable = true;
  };

  # monitors for hyprland
  wayland.windowManager.hyprland.settings.monitor = [
    "DP-3, 2560x1440, 0x0, 1"
    "DP-2, 2560x1440, 0x0, 1"
    "HDMI-A-1, 1920x1080@74.97, -1920x0, 1"
  ];

  # monitors for i3
  xsession.windowManager.i3.config.startup = [
    {
      command = ''
        xrandr --output DisplayPort-2 --auto --right-of HDMI-A-0 \
               --output DisplayPort-2 --mode 2560x1440 \
               --output HDMI-A-0 --mode 1920x1080 --rate 74.97 \
      '';
      always = false;
      notification = false;
    }
  ];
}
