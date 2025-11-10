{
  pkgs,
  lib,
  config,
  ...
}:
let
  small = config.gman.smallscreen.enable;
in
{
  layer = "top";
  height = 41;
  position = "bottom";
  modules-left = [
    "image#thesun"
    "wlr/taskbar"
  ];
  modules-center = [
    "custom/powermenu"
    "hyprland/workspaces"
    "sway/workspaces"
  ];
  modules-right = [
    "tray"
    "battery"
    "custom/microphone"
    "pulseaudio"
    "clock"
    "image#minimizeall"
  ];

  "wlr/taskbar" = {
    format = "{icon}";
    icon-size = if small then 22 else 28;
    tooltip-format = "{title}";
    on-click = "activate";
    on-click-middle = "close";
  };

  "custom/powermenu" = {
    format = " ";
    tooltip = false;
    menu = "on-click";
    menu-file = "${config.xdg.configHome}/waybar/power-menu.xml";
    menu-actions = {
      shutdown = "systemctl poweroff";
      sleep = "systemctl suspend";
      lockscreen = "hyprlock || swaylock -f";
      reboot = "systemctl reboot";
      logout = "uwsm stop";
    };
  };

  "hyprland/workspaces" = {

  };
  "sway/workspaces" = {
    all-outputs = lib.mkDefault false;
  };

  "image#minimizeall" = {
    path = "${pkgs.images.minimizeall}";
    size = 32;
    interval = 5;
  };

  "image#thesun" = {
    path = "${pkgs.images.the-sun}";
    size = 32;
    on-click = "rofi -show drun";
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

  "tray" = {
    icon-size = if small then 16 else 21;
    spacing = if small then 7 else 10;
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

  "clock" = {
    format = "{:%R}";
    tooltip-format = "<tt><small>{calendar}</small></tt>";
    calendar = {
      mode = "year";
      mode-mon-col = 3;
      weeks-pos = "right";
      on-scroll = 1;
      on-click-right = "mode";
      format = {
        months = "<span color='#ffead3'><b>{}</b></span>";
        days = "<span color='#9564FD'><b>{}</b></span>";
        weeks = "<span color='#99ffdd'><b>W{}</b></span>";
        weekdays = "<span color='#ffcc66'><b>{}</b></span>";
        today = "<span color='#ff6699'><b><u>{}</u></b></span>";
      };
    };
  };
}
