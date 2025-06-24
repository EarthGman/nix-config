{ pkgs, lib, config, ... }:
let
  inherit (lib) mkIf mkDefault mkEnableOption;
  cfg = config.profiles.waybar.default;
  scripts = import ../../../scripts { inherit pkgs lib config; };
in
{
  options.profiles.waybar.default.enable = mkEnableOption "default waybar profile";

  config = mkIf cfg.enable {
    home.packages = mkIf config.programs.waybar.enable (with pkgs; [ nerd-fonts.meslo-lg ]);
    services.network-manager-applet.enable = mkDefault true;
    services.blueman-applet.enable = mkDefault true;
    stylix.targets.waybar = {
      addCss = mkDefault false;
    };
    programs.waybar = {
      bottomBar.settings = import ./bottom.nix { inherit pkgs lib config scripts; };
      style = builtins.readFile ./style.css;
    };
    xdg.configFile = {
      "waybar/settings-menu.xml" = {
        enable = config.programs.waybar.enable && !config.programs.waybar.imperativeConfig;
        text = mkDefault (builtins.readFile ./settings-menu.xml);
      };
    };
  };
}
