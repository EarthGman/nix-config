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
      gthumb.enable = lib.mkDefault true;
      vlc.enable = lib.mkDefault true;
      evince.enable = lib.mkDefault true;
      gnome-calculator.enable = lib.mkDefault true;
    };

    # battery notifier (gnome already has one)
    services = {
      batsignal.enable = lib.mkDefault (
        config.meta.desktop == "hyprland" || config.meta.desktop == "sway"
      );

      # set a low timeout for gpg agent for security purposes
      gpg-agent = {
        maxCacheTtl = lib.mkDefault 300;
        maxCacheTtlSsh = lib.mkDefault 300;
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
