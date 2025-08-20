{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gman.hardware-tools;
in
{
  options.gman.hardware-tools.enable = lib.mkEnableOption "hardware diagnostic tools";
  config = lib.mkIf cfg.enable {
    environment.systemPackages = builtins.attrValues {
      inherit (pkgs)
        usbutils
        hdparm
        pciutils
        lshw
        inxi
        ;
    };
  };
}
