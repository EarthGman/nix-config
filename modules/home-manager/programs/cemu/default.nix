{ lib, config, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.cemu;
in
{
  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
