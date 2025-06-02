{ pkgs, lib, config, ... }:
let
  inherit (lib) mkDefault;
  cfg = config.modules.gpu.amd;
in
{
  options.modules.gpu.amd.enable = lib.mkEnableOption "amdgpu module";
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      radeontop
    ];
    services = {
      xserver.videoDrivers = [ "amdgpu" ];
      lact.enable = mkDefault true;
    };
    hardware = {
      amdgpu.overdrive.enable = mkDefault true;
      graphics = {
        extraPackages = with pkgs; [
          libvdpau-va-gl
        ];
      };
    };
  };
}
