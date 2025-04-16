{ pkgs, lib, config, ... }:
{
  config = lib.mkIf (config.services.keyd.enable) {
    environment.systemPackages = [ pkgs.keyd ];
  };
}
