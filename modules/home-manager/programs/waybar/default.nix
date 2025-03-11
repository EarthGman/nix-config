{ pkgs, lib, config, hostName, ... }:
let
  inherit (lib) mkIf mkOption mkEnableOption types;
  cfg = config.programs.waybar;
  scripts = import ../../scripts { inherit pkgs lib config; };
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
      systemd.enable = true;
      bottomBar.settings = import ./bottom-bar.nix { inherit pkgs config lib hostName scripts; };
      settings = mkIf (!cfg.imperativeConfig) [
        cfg.topBar.settings
        cfg.bottomBar.settings
      ];
      style = builtins.readFile ./themes/${config.programs.waybar.theme}/style.css;
    };

    # settings menu
    xdg.configFile = mkIf (!cfg.imperativeConfig) {
      "waybar/settings-menu.xml" = {
        enable = cfg.enable;
        text = builtins.readFile ./settings-menu.xml;
      };
    };
  };
}
