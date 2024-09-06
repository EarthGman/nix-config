{ outputs, pkgs, ... }:
{
  stylix.image = outputs.wallpapers.scarlet-tree-dark;
  stylix.fonts.sizes = {
    terminal = 12;
  };
  # stylix.cursor = {
  #   package = pkgs.posy-cursors;
  #   name = "left_ptr";
  # };

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
