{ lib, ... }:
let
  inherit (lib) mkDefault;
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
    polybar = enabled;
    picom = enabled;
  };

  xsession = {
    enable = true;
    windowManager.i3 = {
      enable = true;
      config.startup = [
        {
          # give some env vars to systemd
          command = "systemctl --user import-environment XDG_CURRENT_DESKTOP PATH";
          always = false;
          notification = false;
        }
        {
          command = "systemctl --user restart polybar.service";
          always = false;
          notification = false;
        }
      ];
    };
  };
}
