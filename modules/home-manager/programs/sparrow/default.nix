{ lib, config, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.sparrow;
in
{
  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
