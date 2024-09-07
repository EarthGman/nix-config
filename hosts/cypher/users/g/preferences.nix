{ self, outputs, ... }:
let
  template = self + /templates/home-manager;
in
{
  imports = [
    template
  ];

  stylix.image = outputs.wallpapers.kaori;
  stylix.colorScheme = "april";

  custom = {
    firefox.theme.name = "shyfox";
    firefox.theme.config.wallpaper = outputs.wallpapers.april-night;

    dolphin-emu.enable = true;
    lutris.enable = true;
    davinci-resolve.enable = true;
    musescore.enable = true;

    looking-glass.enable = true;
    looking-glass.version = "B6";

    ygo-omega.enable = true;
  };
}
