{
  pkgs,
  lib,
  config,
  ...
}@args:
let
  wallpapers = if args ? wallpapers then args.wallpapers else null;
  icons = if args ? wallpapers then args.icons else null;

  inherit (lib) mkIf mkEnableOption;
  inherit (builtins) fetchurl;
  cfg = config.profiles.desktopThemes.cozy-undertale;
in
{
  options.profiles.desktopThemes.cozy-undertale.enable =
    mkEnableOption "cozy undertale desktop theme";
  config = mkIf cfg.enable {
    custom.wallpaper = fetchurl wallpapers.home;

    profiles = {
      firefox.shyfox.config.wallpaper = fetchurl wallpapers.mt-ebott-alt;
      stylix.default.colorScheme = "spring-garden";
    };
    programs.fastfetch = {
      settings.logo = {
        height = 15;
        width = 36;
      };
      imageRandomizer = {
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
        name = "8\-bit Operator+";
        package = pkgs."8-bit-operator-font";
      };
      serif = {
        name = "8\-bit Operator+";
        package = pkgs."8-bit-operator-font";
      };
      monospace = {
        name = "8\-bit Operator+";
        package = pkgs."8-bit-operator-font";
      };
      emoji = {
        name = "8\-bit Operator+";
        package = pkgs."8-bit-operator-font";
      };

      sizes = {
        applications = 12;
        desktop = 12;
        popups = 10;
        terminal = 16;
      };
    };
    programs.waybar.bottomBar.settings."memory".format = "  {percentage}%";
  };
}
