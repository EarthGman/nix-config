{ pkgs, lib, wallpapers, ... }:
let
  inherit (lib) mkForce;
in
{
  stylix.image = builtins.fetchurl wallpapers.grillbys;
  stylix.colorScheme = "faraway";

  programs = {
    #tobyfox
    firefox.theme.name = "shyfox";
    firefox.theme.config.wallpaper = builtins.fetchurl wallpapers.mt-ebott-alt;
    waybar.theme = "headspace";
    vscode.userSettings = {
      editor = {
        "fontFamily" = mkForce "'OMORI_GAME'";
        "fontSize" = mkForce "32";
      };
      window = {
        "zoomLevel" = mkForce 1;
      };
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
