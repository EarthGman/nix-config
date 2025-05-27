{ lib, ... }:
let
  inherit (lib) mkOption types;
in
{
  alacritty = mkOption {
    type = types.str;
    description = "alacritty profile to use";
    default = "";
  };

  fastfetch = mkOption {
    type = types.str;
    description = "fastfetch profile to use";
    default = "";
  };

  kitty = mkOption {
    type = types.str;
    description = "kitty profile to use";
    default = "";
  };

  rofi = mkOption {
    type = types.str;
    description = "rofi profile to use";
    default = "";
  };

  swaylock = mkOption {
    type = types.str;
    description = "swaylock profile to use";
    default = "";
  };

  vscode = mkOption {
    type = types.str;
    description = "vscode profile to use";
    default = "";
  };

  polybar = mkOption {
    type = types.str;
    description = "polybar profile to use";
    default = "";
  };

  waybar = mkOption {
    type = types.str;
    description = "waybar profile to use";
    default = "";
  };

  rmpc = mkOption {
    type = types.str;
    description = "rmpc profile to use";
    default = "";
  };

  zsh = mkOption {
    type = types.str;
    description = "zsh profile to use";
    default = "";
  };

  tmux = mkOption {
    type = types.str;
    description = "tmux profile to use";
    default = "";
  };

  desktops = {
    gnome = mkOption {
      type = types.str;
      description = "gnome profile to use";
      default = "";
    };
    i3 = mkOption {
      type = types.str;
      description = "i3 profile to use";
      default = "";
    };
    sway = mkOption {
      type = types.str;
      description = "sway profile to use";
      default = "";
    };
    hyprland = mkOption {
      type = types.str;
      description = "hyprland profile to use";
      default = "";
    };
  };

  desktopTheme = mkOption {
    description = ''
      enables the specified desktop theme from profiles.desktopThemes
      string should be the name of the file / home-manager option
      ex. for cosmos type "cosmos"
    '';
    type = types.str;
    default = "";
  };
}
