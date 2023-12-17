{
  services.xserver.videoDrivers = [ "amdgpu" ];
  # Enable OpenGL00
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
}
