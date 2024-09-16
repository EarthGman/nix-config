{ lib, config, ... }:
let
  inherit (lib) mkDefault;
  defaultWP = config.stylix.image;
in
{
  services.hyprpaper = {
    settings = {
      ipc = "on";
      splash = mkDefault false;
      preload = mkDefault [
        defaultWP
      ];
      wallpaper = mkDefault [ defaultWP ];
    };
  };
}
