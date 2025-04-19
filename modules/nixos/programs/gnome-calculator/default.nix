{ config, lib, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.gnome-calculator;
in
{
  config = mkIf cfg.enable {
    environment.systemPackages = [
      cfg.package
    ];
  };
}
