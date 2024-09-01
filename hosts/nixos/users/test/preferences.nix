{ outputs, ... }:
{
  stylix.image = outputs.wallpapers.scarlet-tree-dark;
  stylix.colorScheme = "ashes";

  mupdf.enable = false;
  switcheroo.enable = false;

  firefox.theme.name = "shyfox";
  firefox.theme.config.wallpaper = outputs.wallpapers.blackspace;

  services.polybar.settings = {
    "bar/top" = {
      height = "16pt";
      font-0 = "MesloLGS Nerd Font Mono:size=14;4";
    };
    "bar/bottom" = {
      height = "16pt";
      font-0 = "MesloLGS Nerd Font Mono:size=14;4";
    };
  };
}
