{ pkgs, lib, config, ... }:
let
  inherit (lib) optionals mkDefault;
  enabled = { enable = mkDefault true; };
  scripts = import ../scripts { inherit pkgs lib config; };

  # hackfix until I figure out UWSM
  startupScript = pkgs.writeScript "sway-startup.sh" ''
    sleep 1
    systemctl --user restart waybar
    systemctl --user restart network-manager-applet
    systemctl --user restart blueman-applet
    systemctl --user restart hyprland-windows-for-sway-i3
  '';
in
{
  imports = [
    ../i3-sway
  ];

  programs = {
    pwvucontrol = enabled;
    rofi = enabled;
    waybar = enabled;
    swww = enabled;
  };

  wayland.windowManager.sway = {
    enable = true;
    config = {
      output."*" = lib.mkForce { };
      startup = [
        {
          command = "swww-daemon --no-cache";
          always = false;
        }
        {
          command = "${startupScript}";
          always = false;
        }
      ] ++ optionals (!(config.services.omori-calendar-project.enable)) [
        {
          command = "${scripts.invoke_wallpaper_wayland} ${config.stylix.image}";
          always = true;
        }
      ];
    };
  };
}
