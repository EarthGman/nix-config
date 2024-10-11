{ pkgs, config, lib, ... }:
let
  cfg = config.modules.gpu.nvidia;
in
{
  options.modules.gpu.nvidia.enable = lib.mkEnableOption "enable nvidia drivers";
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.nvtopPackages.nvidia ];
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.nvidia = {
      # Modesetting is needed most of the time
      modesetting.enable = true;

      # Enable power management (do not disable this unless you have a reason to).
      # Likely to cause problems on laptops and with screen tearing if disabled.
      powerManagement.enable = true;
      open = false;
      # Enable the Nvidia settings menu,
      # accessible via `nvidia-settings`.
      nvidiaSettings = true;

      package = lib.mkDefault config.boot.kernelPackages.nvidiaPackages.latest;
    };
  };
}
