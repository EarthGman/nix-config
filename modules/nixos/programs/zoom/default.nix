{ lib, config, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.zoom;
in
{
  config = mkIf cfg.enable {
    environment.systemPackages = [
      cfg.package
    ];
  };
}
