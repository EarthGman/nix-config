{ config, lib, pkgs, ... }:
let
  inherit (lib) literalExpression mkEnableOption mkOption mkIf types;
  cfg = config.programs.zed;
  jsonFormat = pkgs.formats.json { };
in
{
  options = {
    programs.zed = {

      enable = mkEnableOption "enable Z editor";

      package = mkOption {
        type = types.package;
        default = pkgs.zed-editor;
        defaultText = literalExpression "pkgs.zed-editor";
      };

      settings = mkOption {
        type = jsonFormat.type;
        description = "settings written to ~/.config/zed/settings.json";
        default = { };
      };

      # not finished
      extensions = mkOption {
        type = types.listOf types.package;
        default = [ ];
        description = "extensions added to zed";
      };

    };
  };
  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];

    home.file = {
      ".config/zed/settings.json" = mkIf (cfg.settings != { }) {
        source = jsonFormat.generate "zed-settings.json" cfg.settings;
      };
    };
  };
}
