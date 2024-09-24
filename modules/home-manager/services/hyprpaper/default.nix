{ lib, config, ... }:
let
  inherit (lib) mkDefault;
  defaultWP = config.stylix.image;
in
{
  options.services.hyprpaper.sourceDirectory = lib.mkOption {
    description = "path to the wallpapers directory";
    type = lib.types.str;
    default = "${config.home.homeDirectory}/Pictures/wallpapers";
  };
  config = {
    services.hyprpaper = {
      settings = {
        ipc = "on";
        splash = mkDefault false;
        preload = [
          defaultWP
        ];
        wallpaper = [ defaultWP ];
      };
    };
  };
}
