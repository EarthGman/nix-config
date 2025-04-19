{ lib, config, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.cbonsai;
in
{
  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
