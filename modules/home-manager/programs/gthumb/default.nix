{ config, lib, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.gthumb;
in
{
  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
