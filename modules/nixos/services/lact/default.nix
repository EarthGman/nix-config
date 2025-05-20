{ pkgs, lib, config, ... }:
let
  inherit (lib) mkEnableOption mkPackageOption mkIf;
  cfg = config.services.lact;
in
{
  options.services.lact = {
    enable = mkEnableOption "lact dameon";
    package = mkPackageOption pkgs "lact" { };
  };

  config = mkIf cfg.enable {
    boot.kernelParams = [ "amdgpu.ppfeaturemask=0xffffffff" ]; # needed for fan control
    environment.systemPackages = [ cfg.package ];

    # nixpkgs doesn't ship with the systemd unit
    # https://github.com/NixOS/nixpkgs/issues/317544
    systemd = {
      packages = [ cfg.package ];
      services.lactd.wantedBy = [ "multi-user.target" ];
    };
  };
}
