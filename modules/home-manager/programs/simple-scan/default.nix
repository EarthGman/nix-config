{ lib, config, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.simple-scan;
in
{
  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
