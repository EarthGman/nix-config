{ pkgs, lib, config, ... }@args:
let
  wallpapers = if args ? wallpapers then args.wallpapers else null;
  icons = if args ? icons then args.icons else null;

  inherit (builtins) fetchurl;
  inherit (lib) mkForce mkEnableOption mkIf;
  cfg = config.profiles.desktopThemes.faraway;
in
{
  options.profiles.desktopThemes.faraway.enable = mkEnableOption "faraway desktop theme from OMORI";
  config = mkIf cfg.enable {
    programs = {
      firefox.themes.shyfox.config.wallpaper = fetchurl wallpapers.a-home-for-flowers;
      fastfetch.image = fetchurl icons.oops;
      waybar = {
        bottomBar.settings = {
          "cpu".format = mkForce "  {usage}%";
          "memory".format = mkForce "  {percentage}%";
          "disk".format = mkForce "  {percentage_used}%";
          "clock".format = mkForce "  {:%R   %m.%d.%Y}";
          "pulseaudio".format = mkForce "{icon}  {volume}%";
        };
      };
      vscode.userSettings = {
        editor = {
          "fontFamily" = "'OMORI_GAME'";
          "fontSize" = "24";
        };
        window = {
          "zoomLevel" = 1;
        };
      };
    };

    services.omori-calendar-project.enable = true;
    programs.swaylock.settings.effect-blur = "";

    stylix.colorScheme = "faraway";
    custom.wallpaper = builtins.fetchurl wallpapers.the-gang-grouphug;

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


