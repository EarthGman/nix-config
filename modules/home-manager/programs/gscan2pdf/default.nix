{ lib, config, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.gscan2pdf;
in
{
  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
