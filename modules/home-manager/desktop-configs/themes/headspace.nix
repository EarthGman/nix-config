{ wallpapers, ... }:
{
  stylix.image = builtins.fetchurl wallpapers.the-gang-headspace;
  stylix.colorScheme = "headspace";

  programs = {
    firefox.theme.name = "shyfox";
    firefox.theme.config.wallpaper = builtins.fetchurl wallpapers.headspace-dark;

    waybar.theme = "headspace";
  };
}
