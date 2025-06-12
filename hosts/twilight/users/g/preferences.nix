{ ... }:
{
  profiles.laptop.enable = true;
  profiles.smallscreen.enable = true;
  programs = {
    moonlight.enable = true;
    waybar.bottomBar.settings = {
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
  };
}
