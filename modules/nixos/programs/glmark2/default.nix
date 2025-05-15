{ config, lib, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.glmark2;
in
{
  config = mkIf cfg.enable {
    environment.systemPackages = [
      cfg.package
    ];
  };
}
