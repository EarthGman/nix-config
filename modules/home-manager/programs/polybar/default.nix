{ pkgs, config, lib, ... }:
let
  inherit (lib) mkDefault;
in
{
  options.polybar.enable = lib.mkEnableOption "enable polybar";
  config = lib.mkIf config.polybar.enable {
    services.polybar = {
      enable = true;
      # the systemd unit cannot find user level packages such as: brightnessctl, pamixer, etc
      # home-manager will complain if this is not set so it is forced to do nothing
      script = "";
      settings = {
        "bar/top" = {
          monitor = "\${env:MONITOR:}";
          width = mkDefault "100%";
          height = mkDefault "22pt";
          radius = mkDefault 0;
          background = mkDefault "#101010";
          foreground = mkDefault "#c4c4c4";
          bottom = false;
          line-size = mkDefault "6pt";
          boarder-color = mkDefault "#000000";
          padding-left = mkDefault 0;
          padding-right = mkDefault 1;
          module-margin = mkDefault 1;
          separator = mkDefault "|";
          separator-foreground = mkDefault "#a7a7a7";
          font-0 = mkDefault "MesloLGS Nerd Font Mono:size=20;6";
          cursor-click = mkDefault "pointer";
          cursor-scroll = mkDefault "ns-resize";
          enable-ipc = mkDefault true;

          modules-right = mkDefault "battery memory cpu eth wlan";
        };

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
          separator = mkDefault "|";
          separator-foreground = mkDefault "#a7a7a7";
          font-0 = mkDefault "MesloLGS Nerd Font Mono:size=20;6";
          cursor-click = mkDefault "pointer";
          cursor-scroll = mkDefault "ns-resize";
          enable-ipc = mkDefault true;

          modules-left = mkDefault "xworkspaces xwindow";
          modules-right = mkDefault "volume microphone tools date power-menu";
        };

        "module/systray" = {
          type = "internal/tray";
          format-margin = "8pt";
          tray-spacing = "16pt";
        };

        "module/xworkspaces" = {
          type = "internal/xworkspaces";
          label-active = "%name%";
          label-active-background = "#a7a7a7";
          label-active-foreground = "#11111b";
          label-active-padding = 1;
          label-occupied = "%name%";
          label-occupied-padding = 1;
          label-urgent = "%name%";
          label-urgent-background = "#f38ba8";
          label-urgent-padding = 1;
          label-empty = "%name%";
          label-empty-padding = 1;
        };

        "module/xwindow" = {
          type = "internal/xwindow";
          label = "%title:0:60:...%";
        };

        "module/xkeyboard" = {
          type = "internal/keyboard";
          blacklist-0 = "num lock";
          label-layout-foreground = "#a7a7a7";
          label-indicator-padding = 2;
          label-indicator-margin = 1;
          label-indicator-foreground = "#101010";
          label-indicator-background = "#1d1d1d";
        };

        "module/memory" = {
          type = "internal/memory";
          interval = 2;
          format-prefix = "RAM ";
          format-prefix-foreground = "#a7a7a7";
          label = "%percentage_used:2%%";
        };

        "module/cpu" = {
          type = "internal/cpu";
          interval = 2;
          format-prefix = "CPU ";
          format-prefix-foreground = "#a7a7a7";
          label = "%percentage:2%%";
        };

        "module/volume" = {
          type = "custom/script";
          interval = 0.1;
          format-background = "#101010";

          exec = pkgs.writeScript "volume levels" ''
            percent="%"
            current_volume=$(${pkgs.pamixer}/bin/pamixer --get-volume-human | sed 's/%//')

            if [ $current_volume == "muted" ]; then
              echo " $current_volume"

            elif [ $current_volume -lt 25 ]; then
              echo " $current_volume$percent"

            elif [ $current_volume -lt 75 ]; then
              echo " $current_volume$percent"
  
            else
              echo " $current_volume$percent"
            fi
          '';
          click-right = "${pkgs.pavucontrol}/bin/pavucontrol &";
          click-left = "${pkgs.pamixer}/bin/pamixer -t";
          scroll-up = "${pkgs.pamixer}/bin/pamixer -i 1";
          scroll-down = "${pkgs.pamixer}/bin/pamixer -d 1";
        };

        "module/microphone" = {
          type = "custom/script";
          exec = pkgs.writeScript "input volume level" ''
            current_volume=$(${pkgs.pamixer}/bin/pamixer --default-source --get-volume-human)

            if [ $current_volume == "muted" ] || [ $current_volume == "0%" ]; then
              echo " $current_volume"
            else
              echo " $current_volume"
            fi
          '';
          interval = 0.1;

          click-left = "${pkgs.pamixer}/bin/pamixer -t --default-source";
          click-right = "${pkgs.pavucontrol}/bin/pavucontrol &";
          scroll-up = "${pkgs.pamixer}/bin/pamixer -i 1 --default-source";
          scroll-down = "${pkgs.pamixer}/bin/pamixer -d 1 --default-source";
        };

        # TODO finish brightness
        # "module/brightness" = {
        #   type = "custom/script";
        #   exec = ""
        # };

        "module/battery" = {
          type = "internal/battery";
          format-prefix = "BAT ";
          format-prefix-foreground = "#a7a7a7";
          full-at = 99;
          format-charging = "<animation-charging> <label-charging>";
          animation-charging-0 = "";
          animation-charging-1 = "";
          animation-charging-2 = "";
          animation-charging-3 = "";
          animation-charging-4 = "";
          animation-charging-framerate = 750;
          animation-charging-foreground = "#fab387";
          format-discharging = "<ramp-capacity> <label-discharging>";
          ramp-capacity-0 = "";
          ramp-capacity-1 = "";
          ramp-capacity-2 = "";
          ramp-capacity-3 = "";
          ramp-capacity-4 = "";
          low-at = 5;
          battery = "BAT1";
          adapter = "ACAD";
          poll-interval = 5;
        };

        "module/tools" = {
          type = "custom/menu";
          expand-right = true;
          menu-0-0 = " Screenshot";
          menu-0-0-exec = "${pkgs.flameshot}/bin/flameshot gui &";
          format = "<menu>  <label-toggle>";
          label-open = " Tools";
          label-close = " Close";
          label-seperator = "  ";
        };

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
          menu-0-3-exec = "loginctl lock-session";
          format = "<menu>  <label-toggle>";
          label-open = "";
          # label-close = "";
          label-close = " Close";
          label-separator = "  ";
        };

        "module/wlan" = {
          type = "internal/network";
          interface-type = "wireless";
          interval = 3;

          format-connected = " <label-connected>";
          label-connected = "%essid%";
          label-connected-foreground = "#a7a7a7";

          format-disconnected = "󰤭  No Wifi";
          label-disconnected = "%ifname% disconnected";
          label-disconnected-foreground = "#a7a7a7";
        };

        # TODO not working rn
        # "module/eth" = {
        #   type = "internal/network";
        #   interface-type = "enp3so";
        #   interval = 3;

        #   format-connected = "󰈁 <label-connected>";
        #   label-connected = "%upspeed% %downspeed%";
        #   label-connected-foreground = "#a7a7a7";

        #   format-disconnected = "🌐 <label-disconnected>";
        #   label-disconnected = "%ifname% disconnected";
        #   label-disconnected-foreground = "#a7a7a7";
        # };

        "module/date" = {
          type = "internal/date";
          interval = 1;
          date = "%H:%M";
          date-alt = "%Y-%m-%d %H:%M:%S";

          label = "%date%";
          label-foreground = "#a7a7a7";
        };

        "settings" = {
          screenchange-reload = true;
          pseudo-transparency = true;
        };

      };
    };
  };
}
