{ outputs, lib, pkgs, ... }:
let
  theme = outputs.homeProfiles.desktopThemes.celeste;
in
{
  imports = [
    theme
  ];

  programs.neovim.imperativeLua = true;

  home.packages = with pkgs; [
    gnome-terminal
  ];

  stylix.fonts.sizes = {
    terminal = lib.mkForce 12;
  };

  services.polybar.settings = {
    "bar/bottom" = {
      height = "16pt";
      font-0 = "MesloLGS Nerd Font Mono:size=12;4";
      modules-left = "wlan cpu memory";
    };
  };
}
