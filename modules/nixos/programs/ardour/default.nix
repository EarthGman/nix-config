{ lib, config, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.ardour;
in
{
  config = mkIf cfg.enable {
    environment.systemPackages = [
      cfg.package
    ];
  };
}
