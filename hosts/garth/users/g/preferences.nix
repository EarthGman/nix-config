{ outputs, config, ... }:
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

  services.fehbg.settings.monitors = {
    "0" = {
      image = "${config.stylix.image}";
      scale-mode = "${config.stylix.imageScalingMode}";
    };
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

