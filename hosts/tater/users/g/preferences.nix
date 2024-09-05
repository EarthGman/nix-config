{ outputs, ... }:
{
  stylix.image = outputs.wallpapers.scarlet-tree-dark;

  services.polybar.settings = {
    "bar/top" = {
      height = "16pt";
      font-0 = "MesloLGS Nerd Font Mono:size=12;4";
    };
    "bar/bottom" = {
      height = "16pt";
      font-0 = "MesloLGS Nerd Font Mono:size=12;4";
    };
  };

  #modules
  custom = {
    firefox.theme.name = "";
    firefox.theme.config.wallpaper = outputs.wallpapers.fiery-dragon;
  };
}
