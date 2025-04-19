{ lib, config, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.switcheroo;
in
{
  config = mkIf cfg.enable {
    environment.systemPackages = [
      cfg.package
    ];
  };
}
