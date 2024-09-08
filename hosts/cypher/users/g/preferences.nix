{ self, wallpapers, ... }:
let
  template = self + /templates/home-manager/g.nix;
in
{
  imports = [
    template
  ];

  stylix.image = builtins.fetchurl wallpapers.kaori;
  stylix.colorScheme = "april";

  custom = {
    firefox.theme.name = "shyfox";
    firefox.theme.config.wallpaper = builtins.fetchurl wallpapers.april-night;

    dolphin-emu.enable = true;
    lutris.enable = true;
    davinci-resolve.enable = true;

    looking-glass.enable = true;
    looking-glass.version = "B6";

    ygo-omega.enable = true;
  };
}
