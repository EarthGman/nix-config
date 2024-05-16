{ pkgs, ... }:
# AMD GPU drivers
{
  services.xserver.videoDrivers = [ "modesetting" ];
  # Enable OpenGL00
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      rocm-opencl-icd
      rocm-opencl-runtime
    ];
  };
}
