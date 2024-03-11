{ pkgs, ... }:
{
  services.xserver.desktopManager.gnome.enable = true;

  programs.geary.enable = false;
  environment.gnome.excludePackages = (with pkgs; [
    weather
    gnome-photos
    gnome-tour
    gedit
    hexchat
    loupe
  ]) ++ (with pkgs.gnome; [
    cheese
    gnome-music
    epiphany
    geary
    gnome-characters
    nautilus
    tali
    iagno
    hitori
    atomix
    yelp
    gnome-contacts
    gnome-initial-setup
  ]);
}
