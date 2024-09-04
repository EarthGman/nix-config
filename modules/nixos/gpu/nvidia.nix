{ config, lib, ... }:
{
  options.custom.nvidiagpu.enable = lib.mkEnableOption "enable nvidia drivers";
  config = lib.mkIf config.custom.nvidiagpu.enable {
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
