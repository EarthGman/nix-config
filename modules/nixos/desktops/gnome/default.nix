{ pkgs, lib, config, ... }:
{

  services.xserver.desktopManager.gnome.enable = true;
  programs.dconf.enable = true;

  programs.geary.enable = false;
  environment.gnome.excludePackages = (with pkgs; [
    weather
    gnome-tour
    gedit
    hexchat
    loupe
  ]) ++ (with pkgs.gnome; [
    cheese
    gnome-music
    epiphany
    gnome-characters
    tali
    iagno
    hitori
    atomix
    yelp
    gnome-contacts
    gnome-initial-setup
  ]);
}