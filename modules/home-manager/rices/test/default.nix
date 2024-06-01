{ pkgs, ... }:
{
  stylix = {
    image = ./wallpaper.jpg;

    base16Scheme = {
      base00 = "151515";
      base01 = "202020";
      base02 = "303030";
      base03 = "505050";
      base04 = "B0B0B0";
      base05 = "D0D0D0";
      base06 = "E0E0E0";
      base07 = "FFFFFF";
      base08 = "6b14a1";
      base09 = "d00e00";
      base0A = "FF4F15";
      base0B = "00C918";
      base0C = "1FAAAA";
      base0D = "3777E6";
      base0E = "AD00A1";
      base0F = "CC6633";
    };

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
