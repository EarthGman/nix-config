{ lib, config, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.rpi-imager;
in
{
  config = mkIf cfg.enable {
    environment.systemPackages = [
      cfg.package
    ];
  };
}
