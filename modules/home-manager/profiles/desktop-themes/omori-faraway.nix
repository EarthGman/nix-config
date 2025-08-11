{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gman.profiles.desktopThemes.omori-faraway;
in
{
  options.gman.profiles.desktopThemes.omori-faraway = {
    enable = lib.mkEnableOption "faraway desktop theme from OMORI";
    # mostly just a proof of concept (dont actually use this lol)
    config.withOmoriFont = lib.mkEnableOption "the font from the game omori";
  };

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      {
        meta = {
          profiles.stylix = "spring-garden";
          wallpaper = builtins.fetchurl pkgs.wallpapers.omori-gang-5;
        };

        gman.profiles.firefox.shyfox.config.wallpaper =
          builtins.fetchurl pkgs.wallpapers.a-home-for-flowers;

        programs = {
          fastfetch.image = builtins.fetchurl pkgs.icons.oops;

          # remove swaylock blur
          swaylock.settings.effect-blur = "";
        };

        # override default wallpaper with the omori calendar project
        services.omori-calendar-project.enable = true;
      }
      (lib.mkIf cfg.config.withOmoriFont {
        gman.profiles.waybar.windows-11.config.settings-unmerged = {
          "cpu".format = lib.mkForce "  {usage}%";
          "memory".format = lib.mkForce "  {percentage}%";
          "disk".format = lib.mkForce "  {percentage_used}%";
          "clock".format = lib.mkForce "  {:%R   %m.%d.%Y}";
          "pulseaudio".format = lib.mkForce "{icon}  {volume}%";
        };
        programs.vscode.profiles.default.userSettings = {
          editor = {
            fontFamily = "'OMORI_GAME'";
          };
          window = {
            zoomLevel = 1;
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
          # omori font renders small for some reason and is hard to read
          sizes = {
            applications = 16;
            desktop = 16;
            popups = 14;
            terminal = 14;
          };
        };
      })
    ]
  );
}
