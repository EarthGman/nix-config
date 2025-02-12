{ outputs, pkgs, lib, ... }:
let
  theme = outputs.homeProfiles.desktopThemes.determination;
  inherit (lib) mkForce;
in
{
  imports = [
    theme
  ];

  stylix.fonts.sizes = {
    terminal = mkForce 12;
    applications = mkForce 10;
    popups = mkForce 8;
    desktop = mkForce 10;
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

  services.dunst.battery-monitor.enable = true;

  services.polybar.settings = {
    "bar/bottom" = {
      height = "16pt";
      font-0 = "MesloLGS Nerd Font Mono:size=12;4";
      modules-left = "wlan cpu memory";
    };
  };
}
