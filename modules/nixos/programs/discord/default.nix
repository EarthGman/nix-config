{ config, lib, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.discord;
in
{
  config = mkIf cfg.enable {
    environment.systemPackages = [
      cfg.package
    ];
  };
}
