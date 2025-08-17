{ ... }:
{
  gman.smallscreen.enable = true;

  gman.profiles.waybar.windows-11.config.settings-unmerged = {
    modules-left = [
      "custom/settings-menu"
      "network"
      "cpu"
      "memory"
      "disk"
      "temperature"
    ];

    temperature = {
      hwmon-path = "/sys/class/hwmon/hwmon3/temp1_input";
      format = " {icon} {temperatureC}°C";
      format-icons = [
        ""
        ""
        ""
      ];
    };
  };

  wayland.windowManager.hyprland.settings = {
    input = {
      kb_layout = "jp";
    };
  };

  services.kanshi = {
    enable = true;
    settings = [
      {
        profile = {
          name = "work";
          outputs = [
            {
              # external
              criteria = "Dell Inc. DELL E228WFP KU31182L17VS";
              position = "0,0";
              mode = "1680x1050@59.9540Hz";
            }
            {
              # laptop display
              criteria = "LVDS-1";
              position = "1680,250";
              mode = "1366x768@60.0190Hz";
            }
          ];
        };
      }
    ];
  };
}
