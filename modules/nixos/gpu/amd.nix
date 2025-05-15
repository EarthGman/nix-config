{ pkgs, lib, config, ... }:
let
  cfg = config.modules.gpu.amd;
in
{
  options.modules.gpu.amd.enable = lib.mkEnableOption "amdgpu module";
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      radeontop
      lact
    ];
    services.xserver.videoDrivers = [ "amdgpu" ];
    # nixpkgs doesn't ship with the systemd unit
    # https://github.com/NixOS/nixpkgs/issues/317544
    systemd = {
      packages = with pkgs; [ lact ];
      services.lact.enable = true;
    };
    hardware.graphics = {
      extraPackages = with pkgs; [
        libvdpau-va-gl
      ];
    };
  };
}
