{ config, lib, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.openconnect;
in
{
  config = mkIf cfg.enable {
    environment.systemPackages = [
      cfg.package
    ];
  };
}
