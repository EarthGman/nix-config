{
  pkgs,
  lib,
  config,
  ...
}@args:
let
  nixosConfig = if args ? nixosConfig then args.nixosConfig else null;
  inherit (lib)
    mkIf
    mkDefault
    mkEnableOption
    mkMerge
    ;
  inherit (builtins) readFile;
  cfg = config.profiles.waybar.default;
  scripts = import ../../../scripts { inherit pkgs lib config; };

in
{
  options.profiles.waybar.default = {
    enable = mkEnableOption "default waybar profile";
    config = {
      small = mkEnableOption "smaller fonts and boxes for default waybar";
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      services.network-manager-applet.enable =
        if (nixosConfig != null && config.programs.waybar.enable) then
          if (nixosConfig.networking.networkmanager.enable) then mkDefault true else false
        else
          false;

      services.blueman-applet.enable =
        if (nixosConfig != null && config.programs.waybar.enable) then
          if (nixosConfig.services.blueman.enable) then mkDefault true else false
        else
          false;

      stylix.targets.waybar = {
        addCss = mkDefault false;
      };

      programs.waybar = {
        bottomBar.settings = mkMerge [
          (import ./bottom.nix {
            inherit
              pkgs
              lib
              config
              scripts
              ;
          })
          (mkIf cfg.config.small {
            # remove network traffic monitor to conserve space
            height = 30;
            network = {
              format-wifi = " {icon} {essid}";
              format-ethernet = " 󰈁 {ifname}";
            };
          })
        ];
        style =
          if (cfg.config.small) then
            (import ./style-small.nix { inherit config; })
          else
            (import ./style.nix { inherit config; });
      };
    }
    (mkIf config.programs.waybar.enable {
      home.packages = (with pkgs.nerd-fonts; [ meslo-lg ]);

      xdg.configFile = {
        "waybar/settings-menu.xml" = {
          enable = !config.programs.waybar.imperativeConfig;
          text = mkDefault (readFile ./settings-menu.xml);
        };
      };
    })
  ]);
}
