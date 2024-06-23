{ pkgs, lib, inputs, stylix-theme, wallpaper, ... }:
{
  imports = [
    inputs.stylix.homeManagerModules.stylix
  ];
  stylix = {
    enable = true;
    image = ./wallpapers/${wallpaper};
    base16Scheme = lib.mkIf (stylix-theme != null) ./color-palettes/${stylix-theme}.yaml;

    targets = {
      vscode.enable = false;
    };

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };

    fonts = {
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };
      monospace = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans Mono";
      };
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };

    polarity = "dark";
  };
}
