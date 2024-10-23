{ wallpapers, ... }:
let
  inherit (builtins) fetchurl;
in
{
  stylix.image = fetchurl wallpapers.the-pumpkin-patch;
  stylix.colorScheme = "ashes";

  programs.firefox.theme = {
    name = "shyfox";
    config.wallpaper = fetchurl wallpapers.the-nightmare-before-firefox;
  };
}
