{ config, lib, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.gimp;
in
{
  config = mkIf cfg.enable {
    environment.systemPackages = [
      cfg.package
    ];
  };
}
