{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.gman.desktop.enable = lib.mkEnableOption "gman's desktop module";

  config = lib.mkIf config.gman.desktop.enable {
    gman = {
      stylix.enable = lib.mkDefault true;
      hyprland.enable = lib.mkDefault (config.meta.desktop == "hyprland");
      sway.enable = lib.mkDefault (config.meta.desktop == "sway");
      gnome.enable = lib.mkDefault (config.meta.desktop == "gnome");
    };

    # some dependencies
    home.packages =
      (builtins.attrValues {
        inherit (pkgs)
          imagemagick
          ;
      })
      ++ lib.optionals (pkgs.stdenv.isLinux) (
        builtins.attrValues {
          inherit (pkgs)
            brightnessctl
            pamixer
            ;
        }
      );
  };
}
