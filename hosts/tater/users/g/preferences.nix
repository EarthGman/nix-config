{ outputs, lib, ... }:
let
  theme = outputs.homeProfiles.desktopThemes.celeste;
in
{
  imports = [
    theme
  ];

  stylix.fonts.sizes = {
    terminal = lib.mkForce 12;
  };

  services.swww.enable = true;
  services.polybar.settings = {
    "bar/bottom" = {
      height = "16pt";
      font-0 = "MesloLGS Nerd Font Mono:size=12;4";
      modules-left = "wlan cpu memory";
    };
  };
}
