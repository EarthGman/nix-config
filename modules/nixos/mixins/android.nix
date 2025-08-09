{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gman.android;
in
{
  options.gman.android.enable = lib.mkEnableOption "gman's android configuration";
  config = lib.mkIf cfg.enable {
    programs = {
      adb.enable = lib.mkDefault true;
      kdeconnect = {
        enable = lib.mkDefault true;
        package = lib.mkIf (config.meta.desktop == "gnome") pkgs.gnomeExtensions.gsconnect;
      };
      scrcpy.enable = lib.mkDefault true;
    };

    environment.systemPackages = with pkgs; [
      android-tools
      apksigner
    ];

    services.udev.packages = with pkgs; [
      android-udev-rules
    ];
  };
}
