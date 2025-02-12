{ pkgs, lib, config, ... }:
let
  inherit (lib) mkIf mkEnableOption mkOption types;
  cfg = config.programs.xclicker;
in
{
  options.programs.xclicker = {
    enable = mkEnableOption "enable xclicker, an autoclicker for x";

    package = mkOption {
      description = "package for xclicker";
      type = types.package;
      default = pkgs.xclicker;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
