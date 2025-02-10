{ outputs, pkgs, lib, ... }:
let
  theme = outputs.homeProfiles.desktopThemes.celeste;
in
{
  imports = [
    theme
  ];

  stylix.fonts.sizes = {
    terminal = 12;
    applications = 10;
    popups = 8;
    desktop = 10;
  };

  programs = {
    moonlight.enable = true;
    prismlauncher.package = pkgs.prismlauncher;
    ghidra.enable = true;
    bottles.enable = false;
    ardour.enable = false;
    waybar.bottomBar.settings = {
      height = 26;
    };
  };

  services.polybar.settings = {
    "bar/bottom" = {
      height = "16pt";
      font-0 = "MesloLGS Nerd Font Mono:size=12;4";
      modules-left = "wlan cpu memory";
    };
  };
}
