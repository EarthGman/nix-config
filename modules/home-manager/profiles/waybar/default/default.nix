{ pkgs, lib, config, ... }@args:
let
  nixosConfig = if args ? nixosConfig then args.nixosConfig else null;
  inherit (lib) mkIf mkDefault mkEnableOption mkMerge;
  inherit (builtins) readFile;
  cfg = config.profiles.waybar.default;
  scripts = import ../../../scripts { inherit pkgs lib config; };

in
{
  options.profiles.waybar.default = {
    enable = mkEnableOption "default waybar profile";
    small = mkEnableOption "smaller fonts and boxes for default waybar";
  };

  config = mkIf cfg.enable (mkMerge [
    {
      services.network-manager-applet.enable =
        if (nixosConfig != null && config.programs.waybar.enable) then
          if (nixosConfig.networking.networkmanager.enable) then
            mkDefault true
          else
            false
        else
          false;

      services.blueman-applet.enable =
        if (nixosConfig != null && config.programs.waybar.enable) then
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
        bottomBar.settings = mkMerge [
          (import ./bottom.nix { inherit pkgs lib config scripts; })
          (mkIf cfg.small {
            height = 30;
            network = {
              format-wifi = " {icon} {essid}";
              format-ethernet = " 󰈁 {ifname}";
            };
          })
        ];
        style =
          if (cfg.small) then
            (readFile ./small.css)
          else
            (readFile ./style.css);
      };
    }
    (mkIf config.programs.waybar.enable {
      home.packages = (with pkgs.nerd-fonts; [ meslo-lg ]);

      xdg.configFile = {
        "waybar/settings-menu.xml" = {
          enable = config.programs.waybar.enable && !config.programs.waybar.imperativeConfig;
          text = mkDefault (builtins.readFile ./settings-menu.xml);
        };
      };
    })
  ]);
}
