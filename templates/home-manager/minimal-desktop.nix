{ lib, ... }:
let
  inherit (lib) mkDefault;
in
{
  custom = {
    terminal = mkDefault "kitty";
    # less bloated than firefox
    brave.enable = mkDefault true;
    nautilus.enable = mkDefault true;
    openshot.enable = mkDefault true;
    audacity.enable = mkDefault true;
    libreoffice.enable = mkDefault true;
    gimp.enable = mkDefault true;
    gthumb.enable = mkDefault true;
    evince.enable = mkDefault true;
    obsidian.enable = mkDefault true;
    vlc.enable = mkDefault true;
    gnome-system-monitor.enable = mkDefault true;
    gnome-calculator.enable = mkDefault true;
    thunderbird.enable = mkDefault true;
  };
}
