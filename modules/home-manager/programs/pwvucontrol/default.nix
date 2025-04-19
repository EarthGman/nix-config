{ config, lib, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.pwvucontrol;
in
{
  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
