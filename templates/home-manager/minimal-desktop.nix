{ pkgs, lib, ... }:
let
  inherit (lib) mkDefault;
in
{
  custom = {
    terminal = mkDefault "kitty";
    #TODO change to vim later
    preferredEditor = mkDefault "nano";
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
    gnome-system-monitor = mkDefault true;
    gnome-calculator = mkDefault true;
    thunderbird.enable = mkDefault true;
  };
  gtk = {
    enable = true;
    iconTheme = mkDefault {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
  };
  qt = {
    enable = true;
    platformTheme.name = "adwaita";
    style.name = "adwaita-dark";
    style.package = pkgs.adwaita-qt;
  };
}
