{ config, lib, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.nautilus;
in
{
  config = mkIf cfg.enable {
    environment.systemPackages = [
      cfg.package
    ];
  };
}
