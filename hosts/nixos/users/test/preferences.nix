{ outputs, ... }:
{
  stylix.image = outputs.wallpapers.scarlet-tree-dark;
  stylix.colorScheme = "ashes";

  firefox.enable = false;
  mupdf.enable = false;
  switcheroo.enable = false;

  firefox.theme.name = "shyfox";
  firefox.theme.config.wallpaper = outputs.wallpapers.blackspace;
}
