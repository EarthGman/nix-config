{ self, wallpapers, ... }:
let
  template = self + /templates/home-manager;
in
{
  imports = [
    template
  ];

  stylix.image = builtins.fetchurl wallpapers.fiery-dragon;
  stylix.colorScheme = "inferno";
  custom = {
    firefox.theme.name = "shyfox";
    firefox.theme.config.wallpaper = builtins.fetchurl wallpapers.fire-and-flames;

    openconnect.enable = true;
    lutris.enable = true;
  };
}

