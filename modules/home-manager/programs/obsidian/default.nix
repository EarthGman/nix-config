{ pkgs, config, lib, ... }:
let
  inherit (lib) mkIf mkEnableOption mkOption types;
  cfg = config.programs.obsidian;
in
{
  options.programs.obsidian = {
    enable = mkEnableOption "enable obsidian, a note taking app";

    package = mkOption {
      description = "package for obsidian";
      type = types.package;
      default = pkgs.obsidian;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
