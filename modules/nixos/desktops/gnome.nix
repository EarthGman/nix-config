{ pkgs, config, lib, ... }:
let
  inherit (lib) mkDefault mkEnableOption mkIf mkOverride;
  cfg = config.modules.desktops.gnome;
in
{
  options.modules.desktops.gnome.enable = mkEnableOption "enable custom gnome desktop module";
  config = mkIf cfg.enable {
    services.desktopManager.gnome.enable = true;
    modules.display-managers.sddm.enable = mkOverride 800 false;
    services.displayManager.gdm.enable = mkOverride 800 true;
    environment.systemPackages = with pkgs; [
      gnome-tilingShell
    ];

    # exclude all packages built into gnome and allow each user to choose what they want installed
    programs.geary.enable = mkOverride 800 false;
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
