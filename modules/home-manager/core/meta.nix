{ lib, ... }:
{
  options.meta = {
    editor = lib.mkOption {
      description = "String that will be exported 1:1 to your EDITOR env variable in your shell";
      type = lib.types.str;
      default = "";
    };

    terminal = lib.mkOption {
      description = "which terminal emulator is used by default";
      type = lib.types.str;
      default = "";
    };

    fileManager = lib.mkOption {
      description = "preferred fileManager";
      type = lib.types.str;
      default = "";
    };

    browser = lib.mkOption {
      description = "preferred browser";
      type = lib.types.str;
      default = "";
    };

    wallpaper = lib.mkOption {
      description = "path to preferred default wallpaper";
      type = lib.types.path;
      default = null;
    };

    profiles = {
      desktopTheme = lib.mkOption {
        description = "which desktop theme is enabled if any";
        type = lib.types.str;
        default = "";
      };

      eww = lib.mkOption {
        description = "eww profile to use";
        type = lib.types.str;
        default = "";
      };

      fastfetch = lib.mkOption {
        description = "whice fastfetch profile to use";
        type = lib.types.str;
        default = "";
      };

      firefox = lib.mkOption {
        description = "which firefox profile to use";
        type = lib.types.str;
        default = "";
      };

      rofi = lib.mkOption {
        description = "which rofi profile to use";
        type = lib.types.str;
        default = "";
      };

      waybar = lib.mkOption {
        description = "which waybar profile to use";
        type = lib.types.str;
        default = "";
      };
    };
  };
}
