# profile for laptops with screens smaller than 1920x1080
{ lib, config, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.profiles.waybar.smallscreen;
in
{
  options.profiles.waybar.smallscreen.enable = mkEnableOption "waybar profile for smaller screens";
  config = mkIf cfg.enable {
    profiles.waybar.default.enable = true;
    # removes the network traffic as it is quite long
    programs.waybar = {
      bottomBar.settings = {
        height = 30;
        network = {
          format-wifi = " {icon} {essid}";
          format-ethernet = " 󰈁 {ifname}";
        };
      };
      # append small changes to style.css for padding
      style = builtins.readFile ./style.css;
    };
  };
}
