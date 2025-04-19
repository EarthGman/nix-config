{ lib, config, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.okular;
in
{
  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
