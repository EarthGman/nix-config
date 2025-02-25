{ pkgs, lib, config, ... }:
let
  inherit (lib) mkIf mkEnableOption mkOption types;
  cfg = config.programs.okular;
in
{
  options.programs.okular = {
    enable = mkEnableOption "enable okular a pdf viewer of plasma";

    package = mkOption {
      description = "package for okular";
      type = types.package;
      default = pkgs.kdePackages.okular;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
