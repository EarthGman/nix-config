{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.gman.gpu.nvidia;
in
{
  options.gman.gpu.nvidia.enable = lib.mkEnableOption "gman's nvidia gpu configuration";
  config = lib.mkIf cfg.enable {
    # environment.systemPackages = [ pkgs.nvtopPackages.nvidia ];
    services.xserver.videoDrivers = [ "nvidia" ];
    programs = {
      btop.package = pkgs.btop-cuda;
      sway.extraOptions = [ "--unsupported-gpu" ]; # sway will not launch on nvidia without this set
    };
    hardware.nvidia = {
      # Modesetting is needed most of the time
      modesetting.enable = true;

      # Enable power management (do not disable this unless you have a reason to).
      # Likely to cause problems on laptops and with screen tearing if disabled.
      powerManagement.enable = true;

      # use open for RTX 20 series or newer
      open = lib.mkDefault true;
      # Enable the Nvidia settings menu,
      # accessible via `qqnvidia-settings`.
      nvidiaSettings = lib.mkDefault true;

      package = lib.mkDefault config.boot.kernelPackages.nvidiaPackages.beta;
    };
  };
}
