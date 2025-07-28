{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf mkDefault;
  cfg = config.modules.android;
in
{
  options.modules.android.enable = mkEnableOption "enable adb and tools for android";
  config = mkIf cfg.enable {
    programs = {
      adb.enable = mkDefault true;
      kdeconnect = {
        enable = mkDefault true;
      };
      scrcpy.enable = mkDefault true;
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
