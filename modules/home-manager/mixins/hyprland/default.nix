{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gman.hyprland;
in
{
  options.gman.hyprland = {
    enable = lib.mkEnableOption "gman's hyprland configuration";
    config = {
      mainMod = lib.mkOption {
        description = "Modifier for gman's hyprland configuration";
        type = lib.types.str;
        default = "SUPER";
        example = "Alt";
      };
      screenshotKey = lib.mkOption {
        description = "The keyboard key used for taking screenshots";
        type = lib.types.str;
        default = "Print";
      };
    };
  };

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      {
        stylix.targets.hyprland.enable = true;

        # required for openURI
        xdg.portal = {
          enable = true;
          extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
        };

        wayland.windowManager.hyprland = {
          enable = lib.mkDefault true;
          systemd.enable = false;
          settings = import ./settings.nix {
            inherit
              pkgs
              lib
              config
              ;
          };
        };
      }
      (lib.mkIf config.wayland.windowManager.hyprland.enable {
        home.packages = builtins.attrValues {
          inherit (pkgs)
            grimblast
            wl-clipboard
            ;
        };

        programs = {
          rofi.enable = lib.mkDefault true;
          waybar.enable = lib.mkDefault true;
          hyprlock.enable = lib.mkDefault true;
        };

        services = {
          swww.enable = lib.mkDefault true;
          polkit-gnome.enable = lib.mkDefault true;
          swaync.enable = lib.mkDefault true;
          network-manager-applet.enable = lib.mkDefault true;
          # customized hypridle /modules/home-manager/core/services/hypridle.nix
          hypridle = {
            enable = lib.mkDefault true;
            dpms = {
              on-bat.timeout = lib.mkDefault 150;
            };
            hyprlock = {
              on-bat.timeout = lib.mkDefault 150;
            };
            suspend = {
              on-bat.timeout = lib.mkDefault 600;
            };

            settings.general = {
              before_sleep_cmd = "hyprlock";
              after_sleep_cmd = "hyprctl dispatch dpms on";
              ignore_dbus_inhibit = false;
              lock_cmd = "hyprlock";
            };
          };
        };
      })
    ]
  );
}
