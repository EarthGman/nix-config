{ pkgs, config, lib, ... }:
let
  inherit (lib) mkIf mkEnableOption mkOption types;
  cfg = config.programs.bustle;
in

{
  options.programs.bustle = {
    enable = mkEnableOption "enable bustle, a dbus viewer and recorder";

    package = mkOption {
      description = "package for bustle";
      type = types.package;
      default = pkgs.bustle;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
