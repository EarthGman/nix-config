{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.modules.gpu.intel;
in
{
  options.modules.gpu.intel.enable = mkEnableOption "intel gpu module";
  config = mkIf cfg.enable {

    hardware.graphics.extraPackages = with pkgs; [
      vaapiIntel
      libvdpau-va-gl
    ];
  };
}
