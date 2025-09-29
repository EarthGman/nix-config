{
  pkgs,
  lib,
  config,
  ...
}@args:
let
  cfg = config.gman.profiles.waybar.windows-11;
  small = config.gman.smallscreen.enable;
  nixosConfig = if args ? nixosConfig then args.nixosConfig else null;
in
{
  options.gman.profiles.waybar.windows-11 = {
    enable = lib.mkEnableOption "windows 11 -ish style for waybar";

    config = {
      settings-unmerged = lib.mkOption {
        description = "settings for direct tweaks before they are merged into programs.waybar.settings";
        type = lib.types.attrsOf lib.types.anything;
        default = { };
      };
      os-button = lib.mkOption {
        description = "string to use for the os button";
        type = lib.types.str;
        default = "  ";
      };
    };
  };

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      (lib.mkIf config.programs.waybar.enable {
        home.packages = [ pkgs.nerd-fonts.meslo-lg ];

        services.network-manager-applet.enable = true;
        # only enable blueman if nixos has bluetooth configured
        services.blueman-applet.enable = lib.mkDefault (
          nixosConfig != null && nixosConfig.services.blueman.enable
        );
      })
      {
        programs.pwvucontrol.enable = true;
        services.swaync.enable = true;

        gman.profiles.waybar.windows-11.config.settings-unmerged = import ./settings.nix {
          inherit pkgs lib config;
        };

        programs.waybar = {
          settings = [
            config.gman.profiles.waybar.windows-11.config.settings-unmerged
          ];

          style =
            if small then
              (import ./style-small.nix { inherit config; })
            else
              (import ./style.nix { inherit config; });
        };

        xdg.configFile = {
          "waybar/settings-menu.xml" = {
            enable = !config.programs.waybar.imperativeConfig;
            text = lib.mkDefault (builtins.readFile ./settings-menu.xml);
          };
        };
      }
      (lib.mkIf small {
        # remove network traffic monitor to conserve space
        gman.profiles.waybar.windows-11.config.settings-unmerged = {
          height = 30;
          network = {
            format-wifi = " {icon} {essid}";
            format-ethernet = " 󰈁 {ifname}";
          };
        };
      })
    ]
  );
}
