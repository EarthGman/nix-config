{ wallpapers, ... }:
let
  inherit (builtins) fetchurl;
in
{
  stylix.image = fetchurl wallpapers.the-nightmare-of-finding-wallpapers;
  stylix.colorScheme = "ashes";

  programs.firefox.theme = {
    name = "shyfox";
    config.wallpaper = fetchurl wallpapers.the-pumpkin-patch;
  };
}
