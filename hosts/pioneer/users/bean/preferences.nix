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
    discord.enable = true;
  };

  services.polybar.settings = {
    "bar/bottom" = {
      font-0 = "MesloLGL Nerd Font Mono:size = 12;4";
      modules-left = "wlan cpu memory";
    };
  };
}
