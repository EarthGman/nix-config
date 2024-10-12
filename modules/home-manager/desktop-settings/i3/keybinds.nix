{ pkgs, config, getExe, ... }:
let
  mod = config.xsession.windowManager.i3.config.modifier;
  pamixer = "${getExe pkgs.pamixer}";
  brightnessctl = "${getExe pkgs.brightnessctl}";
  maim = "${getExe pkgs.maim}";
  xclip = "${getExe pkgs.xclip}";
in
{
  "${mod}+Return" = "exec ${config.xsession.windowManager.i3.config.terminal}";
  "${mod}+q" = "kill";
  # "${mod}+d" = "exec --no-startup-id dmenu_run";
  "${mod}+space" = "exec ${getExe pkgs.rofi} -show";

  # "${mod}+h" = "focus left";
  # "${mod}+j" = "focus down";
  # "${mod}+k" = "focus up";
  # "${mod}+l" = "focus right";

  "${mod}+Left" = "focus left";
  "${mod}+Down" = "focus down";
  "${mod}+Up" = "focus up";
  "${mod}+Right" = "focus right";

  # move focused window
  # "${mod}+Shift+h" = "move left";
  # "${mod}+Shift+j" = "move down";
  # "${mod}+Shift+k" = "move up";
  # "${mod}+Shift+l" = "move right";

  "${mod}+Shift+Left" = "move left";
  "${mod}+Shift+Down" = "move down";
  "${mod}+Shift+Up" = "move up";
  "${mod}+Shift+Right" = "move right";

  # split in horizontal orientation
  # "${mod}+h" = "split h";

  # split in vertical orientation
  "${mod}+v" = "split v";

  # enter fullscreen mode for the focused container
  "${mod}+f" = "fullscreen toggle";

  # change container layout (stacked, tabbed, toggle split)
  "${mod}+s" = "layout stacking";
  "${mod}+w" = "layout tabbed";
  "${mod}+e" = "layout toggle split";

  # toggle tiling / floating
  "${mod}+Shift+space" = "floating toggle";

  # change focus between tiling / floating windows
  "${mod}+g" = "focus mode_toggle";

  # focus the parent container
  "${mod}+a" = "focus parent";

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

  # restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
  "${mod}+Shift+r" = "restart";
  # exit i3 (logs you out of your X session)
  "${mod}+Shift+e" = "exit i3";

  # screenshots
  "Print" = "exec --no-startup-id \"${maim} | ${xclip} -selection clipboard -t image/png; ${xclip} -selection clipboard -t image/png -o > ~/Pictures/Screenshots/$(date +%F-%H:%M:%S).png\"";
  "Shift+Print" = "exec --no-startup-id \"${maim} -s | ${xclip} -selection clipboard -t image/png; ${xclip} -selection clipboard -t image/png -o > ~/Pictures/Screenshots/$(date +%F-%H:%M:%S).png\"";
  "Control+Print" = "exec --no-startup-id \"${maim} -i $(${pkgs.xdotool}/bin/xdotool getactivewindow) | ${xclip} -selection clipboard -t image/png; ${xclip} -selection clipboard -t image/png -o > ~/Pictures/Screenshots/$(date +%F-%H:%M:%S).png\"";

  "XF86AudioRaiseVolume" = "exec ${pamixer} -i 5";
  "XF86AudioLowerVolume" = "exec ${pamixer} -d 5";
  "XF86AudioMute" = "exec ${pamixer} -t";
  "XF86AudioMicMute" = "exec ${pamixer} -t --default-source";

  "XF86MonBrightnessUp" = "exec --no-startup-id ${brightnessctl} set +5%";
  "XF86MonBrightnessDown" = "exec --no-startup-id ${brightnessctl} set 5%-";
}
