{ pkgs, mkDefault, getExe, ... }:
{
  "bar/bottom" = {
    monitor = "\${env:MONITOR:}";
    width = mkDefault "100%";
    height = mkDefault "28pt";
    radius = mkDefault 0;
    background = mkDefault "#101010";
    foreground = mkDefault "#c4c4c4";
    bottom = true;
    line-size = mkDefault "6pt";
    boarder-color = mkDefault "#000000";
    padding-left = mkDefault 0;
    padding-right = mkDefault 1;
    module-margin = mkDefault 1;
    separator = mkDefault "";
    separator-foreground = mkDefault "#a7a7a7";
    font-0 = mkDefault "MesloLGS Nerd Font Mono:size=16;6";

    cursor-click = mkDefault "pointer";
    cursor-scroll = mkDefault "ns-resize";
    enable-ipc = mkDefault true;

    modules-left = mkDefault "eth wlan cpu memory";
    modules-center = mkDefault "xworkspaces";
    modules-right = mkDefault "battery systray volume microphone date power-menu";
  };

  "module/systray" = {
    type = "internal/tray";
    format-margin = mkDefault "6pt";
    tray-spacing = mkDefault "16pt";
    tray-size = mkDefault "45%";
  };

  "module/xworkspaces" = {
    type = "internal/xworkspaces";
    label-active = "%name%";
    label-active-background = mkDefault "#a7a7a7";
    label-active-foreground = mkDefault "#11111b";
    label-active-padding = mkDefault 1;
    label-occupied = "%name%";
    label-occupied-padding = mkDefault 1;
    label-urgent = "%name%";
    label-urgent-background = mkDefault "#f38ba8";
    label-urgent-padding = mkDefault 1;
    label-empty = "%name%";
    label-empty-padding = mkDefault 1;
  };

  "module/xwindow" = {
    type = "internal/xwindow";
    label = "%title:0:60:...%";
  };

  "module/xkeyboard" = {
    type = "internal/keyboard";
    blacklist-0 = "num lock";
    label-layout-foreground = mkDefault "#a7a7a7";
    label-indicator-padding = mkDefault 2;
    label-indicator-margin = mkDefault 1;
    label-indicator-foreground = mkDefault "#101010";
    label-indicator-background = mkDefault "#1d1d1d";
  };

  "module/memory" = {
    type = "internal/memory";
    interval = mkDefault 2;
    format-prefix = mkDefault " ";
    format-prefix-foreground = mkDefault "#a7a7a7";
    label = "%percentage_used:2%%";
  };

  "module/cpu" = {
    type = "internal/cpu";
    interval = mkDefault 2;
    format-prefix = mkDefault " ";
    format-prefix-foreground = mkDefault "#a7a7a7";
    label = "%percentage:2%%";
  };

  "module/volume" = {
    type = "custom/script";
    interval = mkDefault 0.2;
    format-background = mkDefault "#101010";

    exec = pkgs.writeScript "volume-output-ramp" ''
      current_volume=$(${getExe pkgs.pamixer} --get-volume-human | sed 's/%//')

      if [ $current_volume == "muted" ]; then
        echo " ''${current_volume}%"

      elif [ $current_volume -lt 25 ]; then
        echo " ''${current_volume}%"

      elif [ $current_volume -lt 75 ]; then
        echo " ''${current_volume}%"
  
      else
        echo " ''${current_volume}%"
      fi
    '';
    click-right = "${getExe pkgs.pwvucontrol} &";
    click-left = "${getExe pkgs.pamixer} -t";
    scroll-up = "${getExe pkgs.pamixer} -i 1";
    scroll-down = "${getExe pkgs.pamixer} -d 1";
  };

  "module/microphone" = {
    type = "custom/script";
    exec = pkgs.writeScript "volume-input-ramp" ''
      current_volume=$(${getExe pkgs.pamixer} --default-source --get-volume-human)

      if [ $current_volume == "muted" ] || [ $current_volume == "0%" ]; then
        echo " $current_volume"
      else
        echo " $current_volume"
      fi
    '';
    interval = mkDefault 0.2;

    click-left = "${getExe pkgs.pamixer} -t --default-source";
    click-right = "${getExe pkgs.pwvucontrol} &";
    scroll-up = "${getExe pkgs.pamixer} -i 1 --default-source";
    scroll-down = "${getExe pkgs.pamixer} -d 1 --default-source";
  };

  # TODO finish brightness
  # "module/brightness" = {
  #   type = "custom/script";
  #   exec = ""
  # };

  "module/battery" = {
    type = "internal/battery";
    format-prefix = "BAT ";
    format-prefix-foreground = mkDefault "#a7a7a7";
    full-at = 99;
    format-charging = "<animation-charging> <label-charging>";
    animation-charging-0 = "";
    animation-charging-1 = "";
    animation-charging-2 = "";
    animation-charging-3 = "";
    animation-charging-4 = "";
    animation-charging-framerate = mkDefault 750;
    animation-charging-foreground = mkDefault "#fab387";
    format-discharging = "<ramp-capacity> <label-discharging>";
    ramp-capacity-0 = "";
    ramp-capacity-1 = "";
    ramp-capacity-2 = "";
    ramp-capacity-3 = "";
    ramp-capacity-4 = "";
    low-at = mkDefault 10;
    battery = "BAT1";
    adapter = "ACAD";
    poll-interval = mkDefault 5;
  };

  # "module/tools" = {
  #   type = "custom/menu";
  #   expand-right = true;
  #   menu-0-0 = " Screenshot";
  #   menu-0-0-exec = "${getExe pkgs.flameshot} gui &";
  #   format = "<menu>  <label-toggle>";
  #   label-open = " Tools";
  #   label-close = " Close";
  #   label-seperator = "  ";
  # };

  "module/power-menu" = {
    type = "custom/menu";
    expand-right = true;
    menu-0-0 = "";
    menu-0-0-exec = "systemctl suspend";
    menu-0-1 = "";
    menu-0-1-exec = "reboot";
    menu-0-2 = "";
    menu-0-2-exec = "shutdown now";
    menu-0-3 = "";
    menu-0-3-exec = "i3lock";
    format = "<menu>  <label-toggle>";
    label-open = "";
    label-close = " Close";
    label-separator = "  ";
  };

  "module/wlan" = {
    type = "internal/network";
    interface-type = "wireless";
    interval = mkDefault 3;

    format-connected = "󰖩 <label-connected>";
    format-connected-foreground = mkDefault "#a7a7a7";
    label-connected = "%essid%  %downspeed%  %upspeed%";

    format-disconnected = "󰖪 <label-disconnected>";
    format-disconnected-foreground = mkDefault "#a7a7a7";
    label-disconnected = "Disconnected";
  };

  "module/eth" = {
    type = "internal/network";
    interface-type = "wired";
    interval = mkDefault 3;

    format-connected = "󰈁 <label-connected>";
    format-connected-foreground = "#a7a7a7";
    label-connected = " %downspeed%  %upspeed%";

    format-disconnected = "󰈁 <label-disconnected>";
    format-disconnected-foreground = "#a7a7a7";
    label-disconnected = "Disconnected";
  };

  "module/date" = {
    type = "internal/date";
    interval = mkDefault 1;
    date = " %Y-%m-%d   %H:%M";
    date-alt = " %Y-%m-%d   %H:%M:%S";

    label = "%date%";
    label-foreground = mkDefault "#a7a7a7";
  };

  "settings" = {
    screenchange-reload = mkDefault true;
    pseudo-transparency = mkDefault true;
    icon-theme = mkDefault "hicolor";
  };
}
