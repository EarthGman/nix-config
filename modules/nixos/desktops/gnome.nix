{ pkgs, config, lib, ... }:
{
  options.custom.gnome.enable = lib.mkEnableOption "enable gnome desktop";
  config = lib.mkIf config.custom.gnome.enable {
    services.xserver.desktopManager.gnome.enable = true;

    environment.systemPackages = with pkgs; [
      gnome-tilingShell
    ];

    # exclude all packages built into gnome and allow each user to choose what they want installed
    environment.gnome.excludePackages = with pkgs; [
      gnome-tour
      gedit
      hexchat
      loupe
      snapshot
      gnome-connections
      gnome-text-editor
      gnome-terminal
      gnome-calendar
      gnome-weather
      gnome-music
      gnome-characters
      gnome-clocks
      #gnome-camera
      gnome-calculator
      gnome-maps
      gnome-contacts
      gnome-initial-setup
      gnome-font-viewer
      gnome-disk-utility
      gnome-remote-desktop
      #gnome-online-miners
      gnome-logs
      cheese
      epiphany
      tali
      iagno
      hitori
      atomix
      totem
      yelp
    ];
  };
}
