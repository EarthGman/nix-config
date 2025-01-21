{ pkgs, lib, config, ... }:
let
  radeon-profile = pkgs.writeScript "radeon-profile" ''
    sudo -E ${lib.getExe pkgs.radeon-profile}
  '';
  cfg = config.modules.gpu.amd;
in
{
  options.modules.gpu.amd.enable = lib.mkEnableOption "enable amdgpu module for dedicated cards";
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      radeontop
      glxinfo
    ];
    programs.zsh.shellAliases = {
      "radeon-profile" = radeon-profile;
    };
    services.xserver.videoDrivers = [ "amdgpu" ];
    hardware.graphics = {
      extraPackages = with pkgs; [
        libvdpau-va-gl
      ];
    };
  };
}
