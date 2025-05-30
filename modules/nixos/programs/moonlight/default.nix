{ config, lib, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.moonlight;
in
{
  config = mkIf cfg.enable {
    environment.systemPackages = [
      cfg.package
    ];
  };
}
