{ pkgs, lib, config, ... }@args:
let
  wallpapers = if args ? wallpapers then args.wallpapers else null;
  inherit (lib) mkForce mkEnableOption mkIf;
  cfg = config.profiles.desktopThemes.headspace;
in
{
  options.profiles.desktopThemes.headspace.enable = mkEnableOption "headspace desktop theme from omori";
  config = mkIf cfg.enable {
    custom.wallpaper = builtins.fetchurl wallpapers.the-gang-headspace;
    stylix.colorScheme = "headspace";

    programs = {
      firefox.themes.shyfox.config.wallpaper = builtins.fetchurl wallpapers.headspace-dark;
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
  };
}
