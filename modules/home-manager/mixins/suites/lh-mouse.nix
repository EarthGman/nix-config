{ lib, config, ... }:
{
  options.gman.suites.lh-mouse.enable = lib.mkEnableOption "gman's left handed mouse modules";

  config = lib.mkIf config.gman.suites.lh-mouse.enable {
    wayland.windowManager = {
      hyprland.settings = {
        input.left_handed = true;
      };
      sway.config.input = {
        "type:pointer" = {
          left_handed = "enabled";
        };
      };
    };
  };
}
