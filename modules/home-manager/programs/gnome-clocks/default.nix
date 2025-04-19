{ lib, config, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.gnome-clocks;
in
{
  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
