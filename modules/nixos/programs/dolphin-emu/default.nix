{ lib, config, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.dolphin-emu;
in
{
  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
    services.udev.packages = [ cfg.package ];
  };
}
