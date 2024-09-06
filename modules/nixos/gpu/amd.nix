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
    hardware.graphics = {
      enable = true;
    };
  };
}
