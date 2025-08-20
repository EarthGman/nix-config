{ lib, config, ... }:
{
  options.gman.desktop-utilities.enable = lib.mkEnableOption "gman's chosen lightweight and most useful desktop apps";

  config = lib.mkIf config.gman.desktop-utilities.enable {
    programs = {
      vlc.enable = lib.mkDefault true;
      gthumb.enable = lib.mkDefault true;
      simple-scan.enable = lib.mkDefault true;
      gnome-text-editor.enable = lib.mkDefault true;
      gnome-calculator.enable = lib.mkDefault true;
      gnome-system-monitor.enable = lib.mkDefault true;
      switcheroo.enable = lib.mkDefault true;
      video-trimmer.enable = lib.mkDefault true;

      #not exactly "light" but still useful
      gimp.enable = lib.mkDefault true;
      libreoffice.enable = lib.mkDefault true;
    };
  };
}
