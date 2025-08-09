{
  pkgs,
  lib,
  config,
  ...
}@args:
let
  cfg = config.gman.profiles.waybar.windows-11;
  nixosConfig = if args ? nixosConfig then args.nixosConfig else null;
in
{
  options.gman.profiles.waybar.windows-11 = {
    enable = lib.mkEnableOption "windows 11 -ish style for waybar";

    config = {
      small = lib.mkEnableOption "small form factor for the windows 11 style waybar";
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
        programs.waybar = {
          settings = [
            (import ./settings.nix { inherit pkgs lib config; })
          ];

          style =
            if cfg.config.small then
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
      (lib.mkIf cfg.config.small {
        # remove network traffic monitor to conserve space
        programs.waybar.settings = {
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
