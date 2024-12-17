{ pkgs, lib, config, ... }:
let
  inherit (lib) mkDefault;
  enabled = { enable = mkDefault true; };

  startup = pkgs.writeScript "i3-startup.sh" ''
    systemctl --user import-environment XDG_CURRENT_DESKTOP PATH
    systemctl --user restart polybar
    systemctl --user restart hyprland-windows-for-sway-i3
    ${if config.services.omori-calendar-project.enable then ''
    systemctl --user restart omori-calendar-project
    '' else ""}
  '';
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
          command = "${startup}";
          always = false;
          notification = false;
        }
      ];
    };
  };
}
