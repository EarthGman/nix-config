{ lib, config, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.cemu;
in
{
  config = mkIf cfg.enable {
    environment.systemPackages = [
      cfg.package
    ];
  };
}
