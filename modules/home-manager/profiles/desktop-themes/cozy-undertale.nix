{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gman.profiles.desktopThemes.cozy-undertale;
in
{
  options.gman.profiles.desktopThemes.cozy-undertale.enable =
    lib.mkEnableOption "cozy undertale desktop theme";
  config = lib.mkIf cfg.enable {
    meta = {
      profiles.stylix = "spring-garden";
      wallpaper = pkgs.images.home;
    };

    gman = {
      profiles = {
        firefox.shyfox.config.wallpaper = pkgs.images.mt-ebott-alt;
        waybar.windows-11.config.settings-unmerged."memory".format = "  {percentage}%";
      };
    };

    programs.fastfetch = {
      settings.logo = {
        height = 15;
        width = 36;
      };
      imageRandomizer = {
        enable = true;
        images = [
          (pkgs.images.heart-red)
          (pkgs.images.heart-blue)
          (pkgs.images.heart-orange)
          (pkgs.images.heart-pink)
          (pkgs.images.heart-green)
          (pkgs.images.heart-yellow)
          (pkgs.images.heart-teal)
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
        applications = 14;
        desktop = 12;
        popups = 12;
        terminal = 16;
      };
    };
  };
}
