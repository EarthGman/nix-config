{ pkgs, lib, config, ... }:
let
  radeon-profile = pkgs.writeScript "radeon-profile" ''
    sudo -E ${lib.getExe pkgs.radeon-profile}
  '';
in
{
  options.custom.amdgpu.enable = lib.mkEnableOption "enable amdgpu module for dedicated cards";
  config = lib.mkIf config.custom.amdgpu.enable {
    environment.systemPackages = [ pkgs.radeontop ];
    programs.zsh.shellAliases = {
      "radeon-profile" = radeon-profile;
    };
    services.xserver.videoDrivers = [ "amdgpu" ];
    hardware.opengl = {
      extraPackages = with pkgs; lib.mkDefault [
        # for davinci resolve 6GB of bloat tho
        rocm-opencl-icd
        rocm-opencl-runtime
      ];
    };
  };
}
