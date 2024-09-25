{ wallpapers, ... }:
{
  stylix = {
    image = builtins.fetchurl wallpapers.fiery-dragon;
    colorScheme = "inferno";
  };

  programs = {
    firefox.theme.name = "shyfox";
    firefox.theme.config.wallpaper = builtins.fetchurl wallpapers.fire-and-flames;

    waybar.theme = "inferno";
  };
}
