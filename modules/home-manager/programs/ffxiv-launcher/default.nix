{ pkgs, config, lib, ... }:
let
  inherit (lib) mkIf mkEnableOption mkOption types;
  cfg = config.programs.ffxiv-launcher;
in
{
  options.programs.ffxiv-launcher = {
    enable = mkEnableOption "enable ffxiv-launcher";

    package = mkOption {
      description = "package for ffxiv launcher";
      type = types.package;
      default = pkgs.xivlauncher;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}

