{
  pkgs,
  lib,
  config,
  ...
}:
# default config for hyprland
let
  mainMod = config.gman.hyprland.config.mainMod;
in
{
  # env
  env = [
    "XCURSOR_SIZE,${toString config.stylix.cursor.size}"
    "HYPRCURSOR_SIZE,${toString config.stylix.cursor.size}"
  ];

  #montiors
  monitor = lib.mkDefault [
    ", preferred, auto, 1"
  ];

  # exec one time at login
  exec-once = [
    "uwsm finalize"
  ];

  # exec at every reload (Mod+r)
  exec = [
    "systemctl --user restart swww"
    "systemctl --user restart waybar"
    "systemctl --user restart hypridle"
  ];

  #keybinds
  bind = import ./keybinds.nix {
    inherit
      pkgs
      lib
      config
      mainMod
      ;
  };
  bindm = [
    "${mainMod}, mouse:272, movewindow"
    "${mainMod}, mouse:273, resizewindow"
  ];

  # other settings
  general = {
    gaps_in = lib.mkDefault 2;
    gaps_out = lib.mkDefault 2;
    border_size = lib.mkDefault 2;
    "col.active_border" = lib.mkDefault "rgba(33ccffee) rgba(00ff99ee) 45deg";
    "col.inactive_border" = lib.mkDefault "rgba(595959aa)";
    resize_on_border = false;
    allow_tearing = false;
    layout = "dwindle";
  };

  decoration = {
    rounding = lib.mkDefault 10;
    active_opacity = lib.mkDefault 1.0;
    inactive_opacity = lib.mkDefault 1.0;

    blur = {
      enabled = lib.mkDefault true;
      size = lib.mkDefault 3;
      passes = 1;
      vibrancy = 0.1696;
    };
  };

  animations = {
    enabled = lib.mkDefault true;
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
    force_default_wallpaper = lib.mkDefault 0;
    disable_hyprland_logo = lib.mkDefault true;
  };

  input = {
    kb_layout = lib.mkDefault "us";
    follow_mouse = 1;
    left_handed = lib.mkDefault false;
    sensitivity = 0;

    touchpad = {
      natural_scroll = false;
    };
  };

  device = {
    name = "epic-mouse-v1";
    sensitivity = -0.5;
  };

  windowrulev2 = "suppressevent maxmimze, class:.*";
}
