{
  pkgs,
  lib,
  config,
  ...
}@args:
let
  wallpapers = if args ? wallpapers then args.wallpapers else null;
  inherit (lib)
    mkForce
    mkEnableOption
    mkIf
    mkMerge
    ;
  cfg = config.profiles.desktopThemes.headspace;
in
{
  options.profiles.desktopThemes.headspace = {
    enable = mkEnableOption "headspace desktop theme from omori";
    withOmoriFont = mkEnableOption "the font from the game omori";
  };

  config = mkIf cfg.enable (mkMerge [
    {
      custom.wallpaper = builtins.fetchurl wallpapers.the-gang-headspace;
      stylix.colorScheme = "headspace";

      programs = {
        firefox.themes.shyfox.config.wallpaper = builtins.fetchurl wallpapers.headspace-dark;
        vscode.profiles.default.userSettings = {
          editor = {
            fontFamily = "'OMORI_GAME'";
          };
          window = {
            zoomLevel = 1;
          };
        };
      };
    }
    (mkIf cfg.withOmoriFont {
      programs = {
        waybar = (
          mkIf config.profiles.waybar.default.enable {
            bottomBar.settings = {
              "cpu".format = mkForce "  {usage}%";
              "memory".format = mkForce "  {percentage}%";
              "disk".format = mkForce "  {percentage_used}%";
              "clock".format = mkForce "  {:%R   %m.%d.%Y}";
              "pulseaudio".format = mkForce "{icon}  {volume}%";
            };
          }
        );
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
          applications = 16;
          desktop = 16;
          popups = 14;
          terminal = 14;
        };
      };
    })
  ]);
}
