{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gman.profiles.waybar.the-world-machine;
in
{
  options.gman.profiles.waybar.the-world-machine = {
    enable = lib.mkEnableOption "world machine style for waybar";

    settings-unmerged = lib.mkOption {
      description = "settings for direct tweaks before they are merged into programs.waybar.settings";
      type = lib.types.attrsOf lib.types.anything;
      default = { };
    };
  };
  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs."8-bit-operator-font" ];

    gman.profiles.waybar.the-world-machine.settings-unmerged = import ./settings.nix {
      inherit pkgs lib config;
    };

    xdg.configFile."waybar/power-menu.xml".source = ./power-menu.xml;
    programs.waybar = {
      settings = [
        cfg.settings-unmerged
      ];

      style = import ./style.nix { inherit config; };
    };
  };
}
