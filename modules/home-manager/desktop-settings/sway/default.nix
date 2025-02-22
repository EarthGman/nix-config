{ pkgs, lib, config, ... }:
let
  inherit (lib) mkDefault optionals;
  enabled = { enable = mkDefault true; };
in
{
  imports = [
    ../i3-sway
  ];

  programs = {
    swaylock = enabled;
    pwvucontrol = enabled;
    rofi = enabled;
    waybar = enabled;
  };

  home.packages = with pkgs; [
    wl-clipboard
  ];

  services = {
    swww = enabled;
  };

  wayland.windowManager.sway = {
    enable = true;
    systemd.enable = false;
    config = {
      output."*" = lib.mkForce { };
      startup = [
        {
          command = "uwsm finalize";
        }
        {
          command = "systemctl --user restart waybar";
          always = true;
        }
        {
          command = "swaymsg workspace 1";
          always = false;
        }
        {
          command = "systemctl --user restart swww-daemon";
          always = true;
        }
        {
          command = "swayidle -w before-sleep 'swaylock -f'";
          always = false;
        }
        # dont know why but kanshi seems to not restart properly when sway is reloaded
      ] ++ optionals (config.services.kanshi.enable) [
        {
          command = "systemctl --user restart kanshi";
          always = true;
        }
      ];
    };
  };
}
