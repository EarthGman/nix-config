{ ... }:
{

  custom.profiles.desktopTheme = "undertale";
  profiles.laptop.enable = true;
  profiles.smallscreen.enable = true;

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
