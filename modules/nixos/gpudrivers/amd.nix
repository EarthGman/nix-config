{ pkgs, lib, ... }:
let
  radeon-profile = pkgs.writeScript "radeon-profile" ''
    sudo -E ${lib.getExe pkgs.radeon-profile}
  '';
in
{
  programs.zsh.shellAliases = {
    "radeon-profile" = radeon-profile;
  };
  services.xserver.videoDrivers = [ "amdgpu" ];
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
