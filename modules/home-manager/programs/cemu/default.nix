{ pkgs, lib, config, ... }:
let
  inherit (lib) mkIf mkEnableOption mkOption types;
  cfg = config.programs.cemu;
in
{
  options.programs.cemu = {
    enable = mkEnableOption "enable cemu, a wii u emulator";

    package = mkOption {
      description = "package for cemu";
      type = types.package;
      default = pkgs.cemu;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
