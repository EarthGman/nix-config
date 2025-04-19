{ lib, config, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.r2modman;
in
{
  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
