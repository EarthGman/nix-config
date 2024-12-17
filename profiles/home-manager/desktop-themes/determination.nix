{ pkgs, lib, wallpapers, icons, ... }:
let
  inherit (lib) mkForce;
  inherit (builtins) fetchurl;
in
{
  stylix.image = fetchurl wallpapers.home;
  stylix.colorScheme = "faraway";

  programs = {
    #tobyfox
    firefox.theme.name = "shyfox";
    firefox.theme.config.wallpaper = fetchurl wallpapers.mt-ebott-alt;
    vscode.userSettings = {
      editor = {
        "fontFamily" = mkForce "'OMORI_GAME'";
        "fontSize" = mkForce "32";
      };
      window = {
        "zoomLevel" = mkForce 1;
      };
    };

    fastfetch.imageRandomizer = {
      enable = true;
      images = with icons; [
        (fetchurl heart-red)
        (fetchurl heart-blue)
        (fetchurl heart-orange)
        (fetchurl heart-pink)
        (fetchurl heart-green)
        (fetchurl heart-yellow)
        (fetchurl heart-teal)
      ];
    };
  };
  stylix.fonts = {
    sansSerif = {
      name = "OMORI_GAME";
      package = pkgs.omori-font;
    };
    serif = {
      name = "OMORI_GAME";
      package = pkgs.omori-font;
    };
    monospace = {
      name = "OMORI_GAME";
      package = pkgs.omori-font;
    };
    emoji = {
      name = "OMORI_GAME";
      package = pkgs.omori-font;
    };
    sizes = {
      applications = 24;
      desktop = 18;
      popups = 16;
      terminal = 14;
    };
  };
}
