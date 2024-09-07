{ self, outputs, ... }:
let
  template = self + /templates/home-manager;
in
{
  imports = [
    template
  ];

  stylix.image = outputs.wallpapers.fiery-dragon;
  stylix.colorScheme = "inferno";
  custom = {
    firefox.theme.name = "shyfox";
    firefox.theme.config.wallpaper = outputs.wallpapers.fire-and-flames;

    openconnect.enable = true;
    lutris.enable = true;
  };
}

