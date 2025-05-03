{ lib, config, ... }:
let
  inherit (lib) mkIf mkEnableOption;
in
{
  options.modules.desktops.sway.enable = mkEnableOption "enable sway, a wayland implementation of i3";
  config = mkIf config.modules.desktops.sway.enable {
    programs = {
      sway = {
        enable = true;
      };
      uwsm = {
        enable = true;
        waylandCompositors = {
          sway = {
            prettyName = "Sway";
            comment = "sway compositor managed by UWSM";
            binPath = "/run/current-system/sw/bin/sway";
          };
        };
      };
    };
  };
}
