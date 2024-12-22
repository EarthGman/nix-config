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
    i3lock.settings = {
      ignoreEmptyPassword = mkDefault true;
    };
  };

  services = {
    fehbg = enabled; # background setter for x
    polybar = enabled; # waybar but for x
    picom = enabled; # x compositor that stops screen tearing
  };

  xsession = {
    enable = true;
    windowManager.i3 = {
      enable = true;
      config.startup = [
        {
          command = "systemctl --user restart polybar";
          always = true;
          notification = false;
        }
        {
          command = "i3-msg workspace 1";
          always = false;
          notification = false;
        }
      ] ++ optionals (config.services.fehbg.enable) [
        {
          command = "systemctl --user restart fehbg";
          always = true;
          notification = false;
        }

      ] ++ optionals (config.services.omori-calendar-project.enable) [
        {
          command = "systemctl --user restart omori-calendar-project";
          always = true;
          notification = false;
        }
      ];
    };
  };
}
