{ pkgs, ... }:
{

  services.xserver.desktopManager.gnome.enable = true;

  environment.systemPackages = with pkgs; [
    gnome-tilingShell
  ];

  programs.geary.enable = false;
  environment.gnome.excludePackages = (with pkgs; [
    gnome-tour
    gedit
    hexchat
    loupe
    snapshot
    gnome-connections
    gnome-text-editor
  ]) ++ (with pkgs.gnome; [
    cheese
    epiphany
    tali
    iagno
    hitori
    atomix
    yelp
    gnome-terminal
    gnome-calendar
    gnome-weather
    gnome-music
    gnome-characters
    gnome-clocks
    gnome-maps
    gnome-contacts
    gnome-initial-setup
    gnome-font-viewer
    gnome-disk-utility
    gnome-remote-desktop
    gnome-online-miners
    gnome-logs
  ]);
}
