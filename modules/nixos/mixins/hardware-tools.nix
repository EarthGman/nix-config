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
  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      {
        environment.systemPackages = builtins.attrValues {
          inherit (pkgs)
            usbutils
            hdparm
            pciutils
            lshw
            inxi
            ;
        };
      }
      (lib.mkIf (config.meta.desktop != "") {
        programs = {
          # cpu-z alternative
          cpu-x.enable = true;
          # comphrensive testing suite
          phoronix.enable = true;
          # alternative to crystal disk mark
          kdiskmark.enable = true;
        };
      })
    ]
  );
}
