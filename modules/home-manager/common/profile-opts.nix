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

  bat = mkOption {
    type = types.str;
    description = "bat profile to use";
    default = "";
  };

  dunst = mkOption {
    type = types.str;
    description = "dunst profile to use";
    default = "";
  };

  fastfetch = mkOption {
    type = types.str;
    description = "fastfetch profile to use";
    default = "";
  };

  firefox = mkOption {
    type = types.str;
    description = "firefox profile to use";
    default = "";
  };

  fzf = mkOption {
    type = types.str;
    description = "fzf profile to use";
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

  swaync = mkOption {
    type = types.str;
    description = "swaync profile to use";
    default = "";
  };

  stylix = mkOption {
    type = types.str;
    description = "stylix profile to use";
    default = "";
  };

  starship = mkOption {
    type = types.str;
    description = "starship profile to use";
    default = "";
  };

  lazygit = mkOption {
    type = types.str;
    description = "lazygit profile to use";
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

  yazi = mkOption {
    type = types.str;
    description = "yazi profile to use";
    default = "";
  };

  fish = mkOption {
    type = types.str;
    description = "fish profile to use";
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

  hyprlock = mkOption {
    type = types.str;
    description = "hyprlock profile to use";
    default = "";
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
