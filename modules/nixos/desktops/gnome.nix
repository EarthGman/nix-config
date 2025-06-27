{ pkgs, config, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf mkOverride;
  cfg = config.modules.desktops.gnome;
in
{
  options.modules.desktops.gnome = {
    enable = mkEnableOption "custom gnome module";
    withDefaultPackages = mkEnableOption "default packages for the gnome desktop environment";
  };
  config = mkIf cfg.enable {
    services.desktopManager.gnome.enable = true;

    services.displayManager = {
      sddm.enable = mkOverride 800 false;
      gdm.enable = mkOverride 800 true;
    };

    modules.desktops.gnome.withDefaultPackages = mkOverride 800 false; # exclude all default gnome packages by default

    # exclude all packages built into gnome and allow each user to choose what they want installed
    programs.geary.enable = mkIf (!cfg.withDefaultPackages) (mkOverride 800 false);
    environment.gnome.excludePackages = mkIf (!cfg.withDefaultPackages) (with pkgs; [
      gnome-tour
      gedit
      hexchat
      loupe
      snapshot
      decibels
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
    ]);
  };
}
