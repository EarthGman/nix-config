{ lib, config, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.audacity;
in
{
  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
