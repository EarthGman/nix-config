{ config, lib, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.bustle;
in
{
  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
