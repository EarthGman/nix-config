{ wallpapers, icons, ... }:
{
  stylix = {
    image = builtins.fetchurl wallpapers.kaori;
    colorScheme = "april";
  };

  programs = {
    fastfetch.image = builtins.fetchurl icons.kaori;
    firefox.theme.name = "shyfox";
    firefox.theme.config.wallpaper = builtins.fetchurl wallpapers.april-night;

    waybar.theme = "april";
  };
}
