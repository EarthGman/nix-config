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

    programs = {
      # image viewer
      gthumb.enable = lib.mkDefault true;
      # video player
      vlc.enable = lib.mkDefault true;
      # pdf viewer
      evince.enable = lib.mkDefault true;
      # basic calculator
      gnome-calculator.enable = lib.mkDefault true;
    };

    # battery notifier (gnome already has one)
    services = {
      batsignal.enable = lib.mkDefault (
        config.meta.desktop == "hyprland" || config.meta.desktop == "sway"
      );

      gpg-agent = {
        maxCacheTtl = lib.mkDefault 600;
        maxCacheTtlSsh = lib.mkDefault 600;
      };
    };

    # some dependencies
    home.packages =
      (builtins.attrValues {
        inherit (pkgs)
          imagemagick
          wl-clipboard
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
