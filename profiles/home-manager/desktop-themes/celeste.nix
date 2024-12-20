{ pkgs, lib, wallpapers, icons, ... }:
let
  inherit (builtins) fetchurl;
in
{
  programs = {
    firefox.theme = {
      name = "shyfox";
      config.wallpaper = fetchurl wallpapers.celeste-chill;
    };

    fastfetch.imageRandomizer = {
      enable = true;
      images = with icons; [
        (fetchurl strawberry)
        (fetchurl madeline)
        (fetchurl madeline-2)
        (fetchurl badeline)
      ];
    };
  };

  stylix.image = fetchurl wallpapers.celeste;
  stylix.colorScheme = "ashes";
  stylix.iconTheme = {
    dark = "candy-icons";
    light = "candy-icons";
    package = pkgs.candy-icons;
  };
  stylix.fonts = {
    sansSerif = {
      name = "Montserrat-Bold";
      package = pkgs.montserrat;
    };
    serif = {
      name = "Montserrat-Bold";
      package = pkgs.montserrat;
    };
    monospace = {
      name = "Montserrat-Bold";
      package = pkgs.montserrat;
    };
    emoji = {
      name = "Montserrat-Bold";
      package = pkgs.montserrat;
    };
  };
}
