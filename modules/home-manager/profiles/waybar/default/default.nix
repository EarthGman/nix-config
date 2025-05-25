{ pkgs, lib, config, ... }:
let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.profiles.waybar.default;
  scripts = import ../../../scripts { inherit pkgs lib config; };
in
{
  options.profiles.waybar.default.enable = mkEnableOption "default waybar profile";

  config = mkIf cfg.enable {
    programs.waybar = {
      bottomBar.settings = import ./bottom.nix { inherit pkgs lib config scripts; };
    };
    xdg.configFile = mkIf (!config.programs.waybar.imperativeConfig) {
      "waybar/settings-menu.xml" = {
        enable = config.programs.waybar.enable;
        text = builtins.readFile ./settings-menu.xml;
      };
    };
  };
}
