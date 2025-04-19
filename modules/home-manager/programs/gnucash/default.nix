{ lib, config, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.gnucash;
in
{
  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
