{ pkgs, lib, ... }:
let
  inherit (lib) mkDefault;
  enabled = { enable = mkDefault true; };
in
{
  imports = [
    ../i3-sway
  ];

  programs = {
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
      ];
    };
  };
}
