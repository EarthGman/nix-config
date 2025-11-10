{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gman.plasma;
in
{
  options.gman.plasma.enable = lib.mkEnableOption "gman's plasma configuration for home-manager";

  config = lib.mkIf cfg.enable {
    meta = {
      fileManager = lib.mkOverride 898 "dolphin";
      imageViewer = lib.mkOverride 898 "gwenview";
    };

    programs = {
      gnome-calculator.enable = lib.mkOverride 899 false;
      kalk.enable = lib.mkOverride 899 true;
      evince.enable = lib.mkOverride 899 false;
      okular.enable = lib.mkOverride 899 true;

      gnome-software.enable = lib.mkOverride 899 false;
    };

    services.gpg-agent.pinentry.package = lib.mkOverride 898 pkgs.pinentry-qt;

    # HM and plasma fight for this file and it causes alot of problems
    gtk.gtk2.enable = lib.mkForce false;

    # allow configuration of cursor using plasma UI by default
    gtk.cursorTheme = lib.mkOverride 899 null;
    stylix.cursor = lib.mkOverride 899 null;
  };
}
