{ config, lib, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.openshot;
in
{
  config = mkIf cfg.enable {
    environment.systemPackages = [
      cfg.package
    ];
  };
}
