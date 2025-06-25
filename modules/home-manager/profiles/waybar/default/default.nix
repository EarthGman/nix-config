{ pkgs, lib, config, ... }@args:
let
  nixosConfig = if args ? nixosConfig then args.nixosConfig else null;
  inherit (lib) mkIf mkDefault mkEnableOption;
  cfg = config.profiles.waybar.default;
  scripts = import ../../../scripts { inherit pkgs lib config; };
in
{
  options.profiles.waybar.default.enable = mkEnableOption "default waybar profile";

  config = mkIf cfg.enable {
    home.packages = mkIf config.programs.waybar.enable (with pkgs.nerd-fonts; [ meslo-lg ]);
    services.network-manager-applet.enable =
      if (nixosConfig != null) then
        if (nixosConfig.networking.networkmanager.enable) then
          mkDefault true
        else
          false
      else
        false;

    services.blueman-applet.enable =
      if (nixosConfig != null) then
        if (nixosConfig.services.blueman.enable) then
          mkDefault true
        else
          false
      else
        false;

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
