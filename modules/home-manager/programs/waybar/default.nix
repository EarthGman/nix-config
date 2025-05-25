{ pkgs, lib, config, ... }:
let
  inherit (lib) mkIf mkOption mkDefault mkEnableOption mkForce types;
  cfg = config.programs.waybar;
in
{
  options.programs.waybar = {
    imperativeConfig = mkEnableOption "enable imperative configuration for waybar";
    theme = mkOption {
      description = "theme for waybar";
      type = types.str;
      default = "default";
    };
    topBar.settings = mkOption {
      description = "configuration for the top waybar";
      type = types.anything;
      default = { };
    };
    bottomBar.settings = mkOption {
      description = "configuration for the bottom waybar";
      type = types.anything;
      default = { };
    };
  };
  config = {
    home.packages = [ pkgs.networkmanagerapplet ];
    programs.waybar = {
      systemd.enable = mkDefault true;
      settings =
        if cfg.imperativeConfig
        then mkForce [ ]
        else [
          cfg.topBar.settings
          cfg.bottomBar.settings
        ];
      style = builtins.readFile ./themes/${cfg.theme}/style.css;
    };
  };
}
