{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gman.gpu.amd;
in
{
  options.gman.gpu.amd.enable = lib.mkEnableOption "gman's amdgpu configuration";
  config = lib.mkIf cfg.enable {
    services = {
      xserver.videoDrivers = [ "amdgpu" ];
      lact.enable = lib.mkDefault true;
    };
    hardware = {
      amdgpu.overdrive.enable = lib.mkDefault true;
      graphics = {
        extraPackages = builtins.attrValues {
          inherit (pkgs) libvdpau-va-gl;
        };
      };
    };
  };
}
