{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.gman.gpu.intel;
in
{
  options.gman.gpu.intel.enable = mkEnableOption "gman's intel gpu module";
  config = mkIf cfg.enable {
    hardware.graphics.extraPackages = with pkgs; [
      intel-vaapi-driver
      libvdpau-va-gl
    ];
  };
}
