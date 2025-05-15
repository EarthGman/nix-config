{ lib, config, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.sysbench;
in
{
  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
