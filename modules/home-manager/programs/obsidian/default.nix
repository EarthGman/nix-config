{ config, lib, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.obsidian;
in
{
  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
