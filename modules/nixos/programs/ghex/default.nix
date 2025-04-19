{ lib, config, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.ghex;
in
{
  config = mkIf cfg.enable {
    environment.systemPackages = [
      cfg.package
    ];
  };
}
