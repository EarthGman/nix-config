{ lib, config, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.zoom;
in
{
  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
