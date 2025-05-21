{ outputs, lib, wallpapers, ... }:
let
  inherit (lib) mkForce;
in
{
  profiles.desktopThemes.undertale.enable = true;

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
    applications = mkForce 9;
    popups = mkForce 9;
    desktop = mkForce 9;
  };
}
