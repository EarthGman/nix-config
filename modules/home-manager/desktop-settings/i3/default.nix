{ pkgs, lib, config, ... }:
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
    initExtra = ''
      systemctl --user import-environment XDG_CURRENT_DESKTOP PATH
    '';
    windowManager.i3 = {
      enable = true;
      config.startup = [
        {
          command = "systemctl --user restart polybar";
          always = true;
          notification = false;
        }
      ];
    };
  };
}
