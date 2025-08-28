{
  pkgs,
  config,
  lib,
  ...
}:
let
  mod = config.wayland.windowManager.sway.config.modifier;
  pamixer = "${lib.getExe pkgs.pamixer}";
  brightnessctl = "${lib.getExe pkgs.brightnessctl}";
  fileManager = config.meta.fileManager;
  browser = config.meta.browser;
  terminal = config.meta.terminal;
  screenshot = config.gman.scripts.take-screenshot-wayland;
in
{
  "${mod}+Return" = "exec ${terminal}";
  "${mod}+q" = "kill";
  # "${mod}+d" = "exec --no-startup-id dmenu_run";
  "${mod}+space" = "exec rofi -show";
  "${mod}+b" = "exec ${browser}";
  # special case for yazi to launch properly
  "${mod}+m" = if fileManager == "yazi" then "exec ${terminal} -e yazi" else "exec ${fileManager}";
  "${mod}+w" = "exec rofi -show window";
  "${mod}+t" = "exec swaylock -fF";

  "${mod}+h" = "focus left";
  "${mod}+j" = "focus down";
  "${mod}+k" = "focus up";
  "${mod}+l" = "focus right";

  "${mod}+Left" = "focus left";
  "${mod}+Down" = "focus down";
  "${mod}+Up" = "focus up";
  "${mod}+Right" = "focus right";

  # move focused window
  "${mod}+Control+h" = "move left";
  "${mod}+Control+j" = "move down";
  "${mod}+Control+k" = "move up";
  "${mod}+Control+l" = "move right";

  "${mod}+Control+Left" = "move left";
  "${mod}+Control+Down" = "move down";
  "${mod}+Control+Up" = "move up";
  "${mod}+Control+Right" = "move right";

  # Swap with window to the left
  "${mod}+Shift+h" =
    ''mark --add "swapee"; focus left; swap container with mark "swapee"; focus left; unmark "swapee"'';
  "${mod}+Shift+Left" =
    ''mark --add "swapee"; focus left; swap container with mark "swapee"; focus left; unmark "swapee"'';

  # Swap with window to the right
  "${mod}+Shift+l" =
    ''mark --add "swapee"; focus right; swap container with mark "swapee"; focus right; unmark "swapee"'';
  "${mod}+Shift+Right" =
    ''mark --add "swapee"; focus right; swap container with mark "swapee"; focus right; unmark "swapee"'';
  # Swap with window above
  "${mod}+Shift+k" =
    ''mark --add "swapee"; focus up; swap container with mark "swapee"; focus up; unmark "swapee"'';
  "${mod}+Shift+Up" =
    ''mark --add "swapee"; focus up; swap container with mark "swapee"; focus up; unmark "swapee"'';
  # Swap with window below
  "${mod}+Shift+j" =
    ''mark --add "swapee"; focus down; swap container with mark "swapee"; focus down; unmark "swapee"'';
  "${mod}+Shift+Down" =
    ''mark --add "swapee"; focus down; swap container with mark "swapee"; focus down; unmark "swapee"'';

  # enter fullscreen mode for the focused container
  "${mod}+f" = "fullscreen toggle";

  # enter resize mode
  "${mod}+r" = "mode resize";

  # change container layout (stacked, tabbed, toggle split)
  # "${mod}+s" = "layout stacking";
  # "${mod}+t" = "layout tabbed";
  # "${mod}+e" = "layout toggle split";

  # toggle tiling / floating
  "${mod}+Shift+space" = "floating toggle";

  # change focus between tiling / floating windows
  "${mod}+g" = "focus mode_toggle";

  # focus the parent container
  # "${mod}+a" = "focus parent";

  # switch to workspace
  "${mod}+1" = "workspace number 1";
  "${mod}+2" = "workspace number 2";
  "${mod}+3" = "workspace number 3";
  "${mod}+4" = "workspace number 4";
  "${mod}+5" = "workspace number 5";
  "${mod}+6" = "workspace number 6";
  "${mod}+7" = "workspace number 7";
  "${mod}+8" = "workspace number 8";
  "${mod}+9" = "workspace number 9";
  "${mod}+0" = "workspace number 10";

  # move focused container to workspace
  "${mod}+Shift+1" = "move container to workspace number 1";
  "${mod}+Shift+2" = "move container to workspace number 2";
  "${mod}+Shift+3" = "move container to workspace number 3";
  "${mod}+Shift+4" = "move container to workspace number 4";
  "${mod}+Shift+5" = "move container to workspace number 5";
  "${mod}+Shift+6" = "move container to workspace number 6";
  "${mod}+Shift+7" = "move container to workspace number 7";
  "${mod}+Shift+8" = "move container to workspace number 8";
  "${mod}+Shift+9" = "move container to workspace number 9";
  "${mod}+Shift+0" = "move container to workspace number 10";

  "${mod}+n" = "exec --no-startup-id swaync-client -op";
  "${mod}+Shift+r" = "reload";

  "${mod}+Shift+e" = "uwsm stop";

  # screenshots
  "Shift+Print" = "exec --no-startup-id ${screenshot} screen";

  "Print" = "exec --no-startup-id ${screenshot} selection";

  "Control+Print" = "exec --no-startup-id ${screenshot} window";

  "XF86AudioRaiseVolume" = "exec ${pamixer} -i 5";
  "XF86AudioLowerVolume" = "exec ${pamixer} -d 5";
  "XF86AudioMute" = "exec ${pamixer} -t";
  "XF86AudioMicMute" = "exec ${pamixer} -t --default-source";

  "XF86MonBrightnessUp" = "exec --no-startup-id ${brightnessctl} set +5%";
  "XF86MonBrightnessDown" = "exec --no-startup-id ${brightnessctl} set 5%-";
}
