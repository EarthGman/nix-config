{ config, lib, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.museeks;
in
{
  config = mkIf cfg.enable {
    environment.systemPackages = [
      cfg.package
    ];
  };
}
