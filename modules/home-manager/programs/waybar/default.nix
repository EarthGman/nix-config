{ pkgs, lib, config, hostName, ... }:
let
  cfg = config.programs.waybar;
  scripts = import ../../scripts/default.nix { inherit pkgs lib config; };
in
{
  options.programs.waybar = {
    theme = lib.mkOption {
      description = "theme for waybar";
      type = lib.types.str;
      default = "default";
    };
    topBar.settings = lib.mkOption {
      description = "configuration for the top waybar";
      type = lib.types.anything;
      default = { };
    };
    bottomBar.settings = lib.mkOption {
      description = "configuration for the bottom waybar";
      type = lib.types.anything;
      default = { };
    };
  };
  config = {
    programs.waybar = {
      systemd.enable = true;
      bottomBar.settings = import ./bottom-bar.nix { inherit pkgs config lib hostName scripts; };
      settings = [
        cfg.topBar.settings
        cfg.bottomBar.settings
      ];
      style = builtins.readFile ./themes/${config.programs.waybar.theme}/style.css;
    };

    systemd.user.services.waybar = {
      Unit.After = [ "graphical-session.target" ];
      Service.Slice = [ "app-graphical.slice" ];
    };

    # settings menu
    xdg.configFile = {
      "waybar/settings-menu.xml" = {
        enable = cfg.enable;
        text = builtins.readFile ./settings-menu.xml;
      };
    };
  };
}
