{ pkgs, lib, config, ... }:
let
  inherit (lib) mkDefault;
  enabled = { enable = mkDefault true; };

  startup = pkgs.writeScript "sway-startup.sh" ''
    systemctl --user start swww-daemon	
    sleep 1
    swww img ${config.stylix.image}
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
  };

  services = {
    swww = enabled;
  };

  wayland.windowManager.sway = {
    enable = true;
    config = {
      output."*" = lib.mkForce { };
      startup = [
        {
          command = "${startup}";
          always = false;
        }
      ];
    };
  };
}
