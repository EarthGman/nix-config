{
  pkgs,
  lib,
  config,
  scripts,
  mainMod,
  ...
}:
let
  inherit (lib) getExe;
  fileManager = config.custom.fileManager;
  terminal = config.custom.terminal;
  browser = config.custom.browser;
  pamixer = getExe pkgs.pamixer;
  brightnessctl = getExe pkgs.brightnessctl;
in
[
  "${mainMod}, Return, exec, ${terminal}"
  "${mainMod}, M, exec, ${fileManager}"
  "${mainMod}, Space, exec, rofi -show"

  "${mainMod}, Q, killactive"
  "${mainMod} SHIFT, E, exec, uwsm stop"
  "${mainMod} SHIFT, Space, togglefloating"
  "${mainMod}, P, pseudo"
  "${mainMod}, S, togglesplit"
  "${mainMod}, F, fullscreen"
  "${mainMod}, R, exec, hyprctl reload"
  "${mainMod}, W, exec, rofi -show window"
  "${mainMod} SHIFT, N, exec, swaync-client -op"
  "${mainMod}, N, exec, swaync-client -cp"
  "${mainMod}, T, exec, hyprlock"

  "${mainMod}, left, movefocus, l"
  "${mainMod}, right, movefocus, r"
  "${mainMod}, up, movefocus, u"
  "${mainMod}, down, movefocus, d"

  "${mainMod}, h, movefocus, l"
  "${mainMod}, j, movefocus, d"
  "${mainMod}, k, movefocus, u"
  "${mainMod}, l, movefocus, r"

  "${mainMod} SHIFT, left, movewindow, l"
  "${mainMod} SHIFT, right, movewindow, r"
  "${mainMod} SHIFT, up, movewindow, u"
  "${mainMod} SHIFT, down, movewindow, d"

  "${mainMod} SHIFT, h, movewindow, l"
  "${mainMod} SHIFT, j, movewindow, d"
  "${mainMod} SHIFT, k, movewindow, u"
  "${mainMod} SHIFT, l, movewindow, r"

  "${mainMod}, 1, workspace, 1"
  "${mainMod}, 2, workspace, 2"
  "${mainMod}, 3, workspace, 3"
  "${mainMod}, 4, workspace, 4"
  "${mainMod}, 5, workspace, 5"
  "${mainMod}, 6, workspace, 6"
  "${mainMod}, 7, workspace, 7"
  "${mainMod}, 8, workspace, 8"
  "${mainMod}, 9, workspace, 9"
  "${mainMod}, 0, workspace, 10"

  "${mainMod} SHIFT, 1, movetoworkspacesilent, 1"
  "${mainMod} SHIFT, 2, movetoworkspacesilent, 2"
  "${mainMod} SHIFT, 3, movetoworkspacesilent, 3"
  "${mainMod} SHIFT, 4, movetoworkspacesilent, 4"
  "${mainMod} SHIFT, 5, movetoworkspacesilent, 5"
  "${mainMod} SHIFT, 6, movetoworkspacesilent, 6"
  "${mainMod} SHIFT, 7, movetoworkspacesilent, 7"
  "${mainMod} SHIFT, 8, movetoworkspacesilent, 8"
  "${mainMod} SHIFT, 9, movetoworkspacesilent, 9"
  "${mainMod} SHIFT, 0, movetoworkspacesilent, 10"

  # "${mainMod}, S, togglespecialworkspace, magic"
  "${mainMod} SHIFT, S, movetoworkspace, special:magic"
  # "${mainMod}, mouse_down, workspace, e+1"
  # "${mainMod}, mouse_up, workspace, e-1"

  ", Print, exec, ${scripts.take-screenshot-wayland} selection"
  "SHIFT, Print, exec, ${scripts.take-screenshot-wayland} screen"
  "Control, Print, exec, ${scripts.take-screenshot-wayland} window"

  "${mainMod}, B, exec, ${browser}"

  ",XF86AudioRaiseVolume, exec, ${pamixer} -i 5"
  ",XF86AudioLowerVolume, exec, ${pamixer} -d 5"
  ",XF86AudioMute, exec, ${pamixer} -t"
  ",XF86AudioMicMute, exec, ${pamixer} -t --default-source"

  ",XF86MonBrightnessUp, exec, ${brightnessctl} set +5%"
  ",XF86MonBrightnessDown, exec, ${brightnessctl} set 5%-"
]
