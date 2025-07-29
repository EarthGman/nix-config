{
  pkgs,
  lib,
  config,
  ...
}@args:
let
  wallpapers = if args ? wallpapers then args.wallpapers else null;
  icons = if args ? icons then args.icons else null;

  inherit (builtins) fetchurl;
  inherit (lib) mkIf mkEnableOption;
  cfg = config.profiles.desktopThemes.celeste;
in
{
  options.profiles.desktopThemes.celeste.enable = mkEnableOption "celeste desktop theme";
  config = mkIf cfg.enable {
    profiles = {
      firefox.shyfox.config.wallpaper = fetchurl wallpapers.celeste-chapter-1-end;
      stylix.default.colorScheme = "ashes";
    };
    programs = {
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

    custom.wallpaper = fetchurl wallpapers.celeste-chapter-7-end;
    stylix.iconTheme = {
      dark = "candy-icons";
      light = "candy-icons";
      package = pkgs.candy-icons;
    };
    stylix.fonts = {
      # sansSerif = {
      #   name = "Montserrat-Bold";
      #   package = pkgs.montserrat;
      # };
      # serif = {
      #   name = "Montserrat-Bold";
      #   package = pkgs.montserrat;
      # };
      # monospace = {
      #   name = "Montserrat-Bold";
      #   package = pkgs.montserrat;
      # };
      # emoji = {
      #   name = "Montserrat-Bold";
      #   package = pkgs.montserrat;
      # };
    };
  };
}
