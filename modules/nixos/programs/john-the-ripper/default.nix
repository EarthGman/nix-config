{ lib, config, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.john;
in
{
  config = mkIf cfg.enable {
    environment.systemPackages = [
      cfg.package
    ];
  };
}
