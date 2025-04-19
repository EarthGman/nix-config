{ config, lib, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.gnome-system-monitor;
in
{
  config = mkIf cfg.enable {
    environment.systemPackages = [
      cfg.package
    ];
  };
}
