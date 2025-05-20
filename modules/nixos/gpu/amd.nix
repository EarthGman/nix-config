{ pkgs, lib, config, ... }:
let
  inherit (lib) mkDefault;
  cfg = config.modules.gpu.amd;
in
{
  options.modules.gpu.amd.enable = lib.mkEnableOption "amdgpu module";
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      radeontop
    ];
    services = {
      xserver.videoDrivers = [ "amdgpu" ];
      lact.enable = mkDefault true; # somehow not in nixpkgs, found in /modules/nixos/services/lact
    };
    hardware.graphics = {
      extraPackages = with pkgs; [
        libvdpau-va-gl
      ];
    };
  };
}
