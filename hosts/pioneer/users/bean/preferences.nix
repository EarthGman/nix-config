{ outputs, lib, wallpapers, ... }:
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
    sl.enable = true;
    cmatrix.enable = true;
    cbonsai.enable = true;
    zoom.enable = true; # yay school
  };

  services.polybar.settings = {
    "bar/bottom" = {
      font-0 = "MesloLGL Nerd Font Mono:size = 12;4";
      modules-left = "wlan cpu memory";
    };
  };
}
