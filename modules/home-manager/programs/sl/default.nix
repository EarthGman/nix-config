{ lib, config, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.sl;
in
{
  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
