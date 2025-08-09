{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gman.suites.hardware-tools;
in
{
  options.gman.suites.hardware-tools.enable = lib.mkEnableOption "hardware diagnostic tools";
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      usbutils
      pciutils
      lshw
      inxi
    ];
  };
}
