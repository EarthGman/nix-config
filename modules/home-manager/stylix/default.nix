{ pkgs, lib, inputs, color-scheme, wallpaper, ... }:
let
  default = lib.mkDefault;
in
{
  imports = [
    inputs.stylix.homeManagerModules.stylix
  ];
  stylix = {
    enable = default true;
    image = ./wallpapers/${wallpaper};
    base16Scheme = lib.mkIf (color-scheme != null) ./color-palettes/${color-scheme}.yaml;

    targets = default {
      vscode.enable = false;
    };

    cursor = default {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };

    fonts = default {
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

    polarity = default "dark";
  };
}
