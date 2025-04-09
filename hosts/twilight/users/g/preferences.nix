{ outputs, pkgs, lib, ... }:
let
  inherit (lib) mkForce;
  theme = outputs.homeProfiles.desktopThemes.cosmos;
in
{
  imports = [ theme ];
  programs = {
    prismlauncher.package = pkgs.prismlauncher; # dont build newest version locally
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

      network = {
        format-wifi = " {icon} {essid}";
        format-ethernet = " 󰈁 {ifname}";
      };
      height = 36;
    };
  };

  stylix.fonts.sizes = {
    terminal = mkForce 12;
    applications = mkForce 10;
    popups = mkForce 8;
    desktop = mkForce 10;
  };
  services.dunst.battery-monitor.enable = true;
}
