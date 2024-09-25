{ wallpapers, ... }:
{
  stylix.image = builtins.fetchurl wallpapers.survivors;
  stylix.colorScheme = "vibrant-cool";

  programs = {
    firefox.theme.name = "shyfox";
    firefox.theme.config.wallpaper = builtins.fetchurl wallpapers.get-mooned;
  };
}
