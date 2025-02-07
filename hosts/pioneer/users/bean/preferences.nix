{ outputs, lib, wallpapers, ... }:
let
  inherit (lib) mkForce;
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
  stylix.fonts.sizes = {
    terminal = mkForce 12;
    applications = mkForce 12;
    popups = mkForce 12;
    desktop = mkForce 12;
  };
}
