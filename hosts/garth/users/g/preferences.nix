{ outputs, ... }:
let
  theme = outputs.homeProfiles.desktopThemes.faraway;
in
{
  imports = [
    theme
  ];

  xsession.screensaver = {
    enable = true;
  };

  programs = {
    openconnect.enable = true;
    lutris.enable = true;
    moonlight.enable = true;
    gnome-clocks.enable = true;
  };

  services.dunst.battery-monitor.enable = true;
}

