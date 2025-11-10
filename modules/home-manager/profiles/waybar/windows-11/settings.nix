{
  pkgs,
  config,
  lib,
  ...
}:
{
  name = "waybar";
  layer = "bottom";
  position = "bottom";
  height = lib.mkDefault 41;
  exclusive = true;
  mod = "dock";
  gtk-layer-shell = true;
  passthrough = false;
  modules-left = lib.mkDefault [
    "custom/settings-menu"
    "network"
    "cpu"
    "memory"
    "disk"
    "battery"
  ];
  modules-center = lib.mkDefault [
    "custom/os_button"
    "hyprland/workspaces"
    "sway/workspaces"
  ];
  modules-right = lib.mkDefault [
    "tray"
    "custom/microphone"
    "pulseaudio"
    # "pulseaudio/slider"
    "clock"
    "custom/notifications"
  ];

  "custom/settings-menu" = {
    format = "";
    tooltip = false;
    menu = "on-click";
    menu-file = "${config.xdg.configHome}/waybar/settings-menu.xml";
    menu-actions = {
      shutdown = "systemctl poweroff";
      sleep = "systemctl suspend";
      lockscreen = "hyprlock || swaylock -f";
      reboot = "systemctl reboot";
      logout = "uwsm stop";
      wallpapers = "${config.gman.scripts.rofi-wallpaper-switcher}";
    };
  };

  "hyprland/workspaces" = {
    icon-size = 32;
    spacing = 16;
    on-scroll-up = "hyprctl dispatch workspace r+1";
    on-scroll-down = "hyprctl dispatch workspace r-1";
  };

  "sway/workspaces" = {
    all-outputs = lib.mkDefault false;
    disable-scroll = lib.mkDefault true;
  };

  "custom/os_button" = {
    format = config.gman.profiles.waybar.windows-11.config.os-button;
    on-click = "rofi -show";
    tooltip = false;
  };

  "battery" = {
    states = {
      good = 95;
      warning = 30;
      critical = 10;
    };
    format = "{icon} {capacity}%";
    format-charging = " {capacity}%";
    format-plugged = " {capacity}%";
    format-alt = "{time} {icon}";
    format-icons = [
      "󰂎"
      "󰁺"
      "󰁻"
      "󰁼"
      "󰁽"
      "󰁾"
      "󰁿"
      "󰂀"
      "󰂁"
      "󰂂"
      "󰁹"
    ];
  };

  "network" = {
    format-wifi = lib.mkDefault " {icon} {essid} 󰛀 {bandwidthDownBytes} 󰛃 {bandwidthUpBytes} ";
    format-ethernet = lib.mkDefault " 󰈁 {ifname} 󰛀 {bandwidthDownBytes} 󰛃 {bandwidthUpBytes} ";
    format-disconnected = lib.mkDefault "󰤭  Disconnected ";
    format-icons = [
      "󰤯 "
      "󰤟 "
      "󰤢 "
      "󰤢 "
      "󰤨 "
    ];
    interval = 5;
    tooltip = "true";
    tooltip-format = "LAN: {ipaddr}";
  };

  "cpu" = {
    interval = 5;
    format = lib.mkDefault " {usage}%";
    max-length = 10;
  };

  "disk" = {
    interval = 30;
    format = lib.mkDefault " {percentage_used}%";
    path = "/";
    tooltip = true;
    unit = "GB";
    tooltip-format = "Available {free} of {total}";
  };

  "memory" = {
    interval = 10;
    format = lib.mkDefault " {percentage}%";
    max-length = 10;
    tooltip = true;
    tooltip-format = "RAM - {used:0.1f}GiB used";
  };

  "tray" = {
    icon-size = 18;
    spacing = 3;
  };

  "clock" = {
    format = " {:%R  %m.%d.%Y}";
    tooltip-format = "<tt><small>{calendar}</small></tt>";
    calendar = {
      mode = "year";
      mode-mon-col = 3;
      weeks-pos = "right";
      on-scroll = 1;
      on-click-right = "mode";
      format = {
        months = "<span color='#ffead3'><b>{}</b></span>";
        days = "<span color='#ecc6d9'><b>{}</b></span>";
        weeks = "<span color='#99ffdd'><b>W{}</b></span>";
        weekdays = "<span color='#ffcc66'><b>{}</b></span>";
        today = "<span color='#ff6699'><b><u>{}</u></b></span>";
      };
    };
    actions = {
      on-click-right = "mode";
      on-click-forward = "tz_up";
      on-scroll-down = "shift_down";
      on-scroll-up = "shift_up";
    };
  };

  "custom/notifications" = {
    exec = ''
      UNREAD_NOTIFICATIONS=$(swaync-client --count)
      if [[ $(swaync-client -D) == "false" ]]; then
        case $UNREAD_NOTIFICATIONS in
          0)
            echo 󰂚 
            ;;
          *)
            echo 󰂚 $UNREAD_NOTIFICATIONS
            ;;
      esac
      else
        echo 󰂛 
      fi
    '';
    interval = 1;
    format = "{}";
    tooltip = true;
    tooltip-format = "Notifications";
    on-click = ''
      swaync-client -op
    '';
  };

  "custom/microphone" = {
    exec = ''
      current_volume=$(${lib.getExe pkgs.pamixer} --default-source --get-volume-human)
      if [ $current_volume == "muted" ] || [ $current_volume == "0%" ]; then
        echo "  $current_volume"
      else
        echo " $current_volume"
      fi
    '';
    exec-on-event = true;
    interval = 1;
    format = "{}";
    on-click = "${lib.getExe pkgs.pamixer} -t --default-source";
    on-click-right = "pwvucontrol";
    on-scroll-up = "${lib.getExe pkgs.pamixer} -i 1 --default-source";
    on-scroll-down = "${lib.getExe pkgs.pamixer} -d 1 --default-source";
    tooltip = false;
  };

  "pulseaudio/slider" = {
    min = 0;
    max = 100;
    orientation = "horizontal";
  };

  "pulseaudio" = {
    max-volume = 100;
    scroll-step = 1;
    format = "{icon} {volume}%";
    format-muted = "  muted";
    format-icons = {
      default = [
        " "
        " "
        " "
      ];
    };
    on-click = "${lib.getExe pkgs.pamixer} -t";
    on-click-right = "pwvucontrol";
  };
}
