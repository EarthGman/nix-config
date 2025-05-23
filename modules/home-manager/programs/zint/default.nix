{ lib, config, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.zint;
in
{
  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
