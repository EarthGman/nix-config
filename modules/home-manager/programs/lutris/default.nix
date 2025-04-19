{ config, lib, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.lutris;
in
{
  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
