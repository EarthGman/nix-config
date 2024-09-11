{ lib, config, ... }:
let
  inherit (lib) mkEnableOption mkIf mkDefault;
  defaultWP = config.stylix.image;
in
{
  options.custom.hyprpaper.enable = mkEnableOption "enable hyprpaper service module";
  config = mkIf config.custom.hyprpaper.enable {
    services.hyprpaper = {
      enable = true;
      settings = {
        ipc = "on";
        splash = mkDefault false;
        preload = mkDefault [
          defaultWP
        ];
        wallpaper = mkDefault [ defaultWP ];
      };
    };
  };
}
