{ pkgs, lib, config, ... }:
let
  inherit (lib) mkIf mkEnableOption mkOption types;
  cfg = config.programs.audacity;
in
{
  options.programs.audacity = {
    enable = mkEnableOption "enable audacity, a simple audio editor";

    package = mkOption {
      description = "package for audacity";
      type = types.package;
      default = pkgs.audacity;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
