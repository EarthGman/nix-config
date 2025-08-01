{
  pkgs,
  lib,
  config,
  scripts,
  ...
}:
# default config for hyprland
let
  inherit (lib) mkDefault;
  inherit (builtins) toString;
  mainMod = config.profiles.hyprland.default.mainMod;
in
{
  # env
  env = [
    "XCURSOR_SIZE,${toString config.stylix.cursor.size}"
    "HYPRCURSOR_SIZE,${toString config.stylix.cursor.size}"
  ];

  #montiors
  monitor = mkDefault [
    ", preferred, auto, 1"
  ];

  # exec at every reload (Mod+r)
  exec = [
    "systemctl --user restart swww"
    "systemctl --user restart waybar"
  ];

  #keybinds
  bind = import ./keybinds.nix {
    inherit
      pkgs
      lib
      config
      scripts
      mainMod
      ;
  };
  bindm = [
    "${mainMod}, mouse:272, movewindow"
    "${mainMod}, mouse:273, resizewindow"
  ];

  # other settings
  general = {
    gaps_in = mkDefault 2;
    gaps_out = mkDefault 2;
    border_size = mkDefault 2;
    "col.active_border" = mkDefault "rgba(33ccffee) rgba(00ff99ee) 45deg";
    "col.inactive_border" = mkDefault "rgba(595959aa)";
    resize_on_border = false;
    allow_tearing = false;
    layout = "dwindle";
  };

  decoration = {
    rounding = mkDefault 10;
    active_opacity = mkDefault 1.0;
    inactive_opacity = mkDefault 1.0;

    blur = {
      enabled = mkDefault true;
      size = mkDefault 3;
      passes = 1;
      vibrancy = 0.1696;
    };
  };

  animations = {
    enabled = mkDefault true;
    bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

    animation = [
      "windows, 1, 7, myBezier"
      "windowsOut, 1, 7, default, popin 80%"
      "border, 1, 10, default"
      "borderangle, 1, 8, default"
      "fade, 1, 7, default"
      "workspaces, 1, 6, default"
    ];
  };

  dwindle = {
    pseudotile = true;
    preserve_split = true;
  };

  master = {
    new_status = "master";
  };

  misc = {
    force_default_wallpaper = 0;
    disable_hyprland_logo = mkDefault false;
  };

  input = {
    kb_layout = "us";
    follow_mouse = 1;
    left_handed = mkDefault false;
    sensitivity = 0;

    touchpad = {
      natural_scroll = false;
    };
  };

  gestures = {
    workspace_swipe = false;
  };

  device = {
    name = "epic-mouse-v1";
    sensitivity = -0.5;
  };

  windowrulev2 = "suppressevent maxmimze, class:.*";
}
