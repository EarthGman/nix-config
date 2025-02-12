{ pkgs, config, lib, ... }:
let
  inherit (lib) mkIf mkEnableOption mkOption types;
  cfg = config.programs.dolphin-emu;
in
{
  options.programs.dolphin-emu = {
    enable = mkEnableOption "enable dolphin-emu, a wii and gamecube emulator";
    package = mkOption {
      description = "package for dolphin-emu";
      type = types.package;
      default = pkgs.dolphin-emu-beta;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}

