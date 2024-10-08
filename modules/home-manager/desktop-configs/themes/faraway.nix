{ wallpapers, icons, ... }:
let
  inherit (builtins) fetchurl;
in
{
  programs = {
    firefox.theme.name = "shyfox";
    firefox.theme.config.wallpaper = fetchurl wallpapers.a-home-for-flowers;
    fastfetch.image = fetchurl icons.oops;
  };

  services.omori-calendar-project.enable = true;

  stylix.colorScheme = "faraway";
}
