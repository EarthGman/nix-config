{ config, lib, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.clipgrab;
in
{
  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
