{ pkgs, config, lib, ... }:
let
  inherit (lib) mkIf mkEnableOption mkOption types;
  cfg = config.programs.dosbox;
in
{
  options.programs.dosbox = {
    enable = mkEnableOption "enable dosbox, a DOS emulator";

    package = mkOption {
      description = "dosbox package";
      type = types.package;
      default = pkgs.dosbox-staging;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
