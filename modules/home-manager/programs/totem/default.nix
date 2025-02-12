{ pkgs, lib, config, ... }:
let
  inherit (lib) mkIf mkEnableOption mkOption types;
  cfg = config.programs.totem;
in
{
  options.programs.totem = {
    enable = mkEnableOption "enable totem, a video player from gnome";

    package = mkOption {
      description = "package for totem";
      type = types.package;
      default = pkgs.totem;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
