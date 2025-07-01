{ pkgs, lib, config, ... }@args:
let
  wallpapers = if args ? wallpapers then args.wallpapers else null;
  icons = if args ? icons then args.icons else null;

  inherit (builtins) fetchurl;
  inherit (lib) mkForce mkEnableOption mkIf mkMerge;
  cfg = config.profiles.desktopThemes.faraway;
in
{
  options.profiles.desktopThemes.faraway = {
    enable = mkEnableOption "faraway desktop theme from OMORI";
    withOmoriFont = mkEnableOption "the font from the game omori";
  };

  config = mkIf cfg.enable (mkMerge [
    {
      programs = {
        firefox.themes.shyfox.config.wallpaper = fetchurl wallpapers.a-home-for-flowers;
        fastfetch.image = fetchurl icons.oops;

        swaylock.settings.effect-blur = "";
      };

      services.omori-calendar-project.enable = true;
      stylix.colorScheme = "faraway";
      custom.wallpaper = builtins.fetchurl wallpapers.the-gang-grouphug;
    }
    (mkIf cfg.withOmoriFont {
      programs = {
        waybar = (mkIf config.profiles.waybar.default.enable {
          bottomBar.settings = {
            "cpu".format = mkForce "  {usage}%";
            "memory".format = mkForce "  {percentage}%";
            "disk".format = mkForce "  {percentage_used}%";
            "clock".format = mkForce "  {:%R   %m.%d.%Y}";
            "pulseaudio".format = mkForce "{icon}  {volume}%";
          };
        });
        vscode.profiles.default.userSettings = {
          editor = {
            fontFamily = "'OMORI_GAME'";
          };
          window = {
            zoomLevel = 1;
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
        # omori font renders small for some reason
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


