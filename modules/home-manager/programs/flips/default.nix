{ config, lib, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.flips;
in
{
  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
