{
  pkgs,
  config,
  lib,
  scripts,
  ...
}:
let
  inherit (lib) getExe mkDefault;
in
{
  name = "bottom";
  layer = "bottom";
  position = "bottom";
  height = mkDefault 41;
  exclusive = true;
  mod = "dock";
  gtk-layer-shell = true;
  passthrough = false;
  modules-left = mkDefault [
    "custom/settings-menu"
    "network"
    "cpu"
    "memory"
    "disk"
  ];
  modules-center = mkDefault [
    "custom/os_button"
    "hyprland/workspaces"
    "sway/workspaces"
  ];
  modules-right = mkDefault [
    "battery"
    "tray"
    "custom/microphone"
    "pulseaudio"
    # "pulseaudio/slider"
    "clock"
    "custom/notifications"
  ];

  "custom/settings-menu" = {
    format = "  ";
    tooltip = false;
    menu = "on-click";
    menu-file = "${config.xdg.configHome}/waybar/settings-menu.xml";
    menu-actions = {
      shutdown = "systemctl poweroff";
      sleep = "systemctl suspend";
      lockscreen = "hyprlock || swaylock -f";
      reboot = "systemctl reboot";
      logout = "uwsm stop";
      wallpapers = "${scripts.rofi-wallpaper-switcher}";
    };
  };

  "hyprland/workspaces" = {
    icon-size = 32;
    spacing = 16;
    on-scroll-up = "hyprctl dispatch workspace r+1";
    on-scroll-down = "hyprctl dispatch workspace r-1";
  };

  "sway/workspaces" = {
    all-outputs = mkDefault false;
    disable-scroll = mkDefault true;
  };

  "custom/os_button" = {
    format = mkDefault "  ";
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
    format-wifi = mkDefault " {icon} {essid} 󰛀 {bandwidthDownBytes} 󰛃 {bandwidthUpBytes} ";
    format-ethernet = mkDefault " 󰈁 {ifname} 󰛀 {bandwidthDownBytes} 󰛃 {bandwidthUpBytes} ";
    format-disconnected = mkDefault "󰤭  Disconnected ";
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
    format = mkDefault " {usage}%";
    max-length = 10;
  };

  "disk" = {
    interval = 30;
    format = mkDefault " {percentage_used}%";
    path = "/";
    tooltip = true;
    unit = "GB";
    tooltip-format = "Available {free} of {total}";
  };

  "memory" = {
    interval = 10;
    format = mkDefault " {percentage}%";
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
    # check if Do not Distrurb mode is on
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
      current_volume=$(${getExe pkgs.pamixer} --default-source --get-volume-human)
      if [ $current_volume == "muted" ] || [ $current_volume == "0%" ]; then
        echo "  $current_volume"
      else
        echo " $current_volume"
      fi
    '';
    exec-on-event = true;
    interval = 1;
    format = "{}";
    on-click = "${getExe pkgs.pamixer} -t --default-source";
    on-click-right = "${getExe config.programs.pwvucontrol.package}";
    on-scroll-up = "${getExe pkgs.pamixer} -i 1 --default-source";
    on-scroll-down = "${getExe pkgs.pamixer} -d 1 --default-source";
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
    on-click = "${getExe pkgs.pamixer} -t";
    on-click-right = "${getExe config.programs.pwvucontrol.package}";
  };
}
