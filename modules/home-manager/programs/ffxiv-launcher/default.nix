{ config, lib, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.ffxiv-launcher;
in
{
  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
