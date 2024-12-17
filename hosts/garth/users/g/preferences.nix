{ outputs, ... }:
let
  theme = outputs.homeProfiles.desktopThemes.determination;
in
{
  imports = [
    theme
  ];

  xsession.screensaver = {
    enable = true;
  };

  programs = {
    google-chrome.enable = true;
    openconnect.enable = true;
    lutris.enable = true;
    moonlight.enable = true;
    gnome-clocks.enable = true;
  };

  services.dunst.battery-monitor.enable = true;
}

