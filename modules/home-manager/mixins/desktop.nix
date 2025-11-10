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
      plasma.enable = lib.mkDefault (config.meta.desktop == "plasma");
    };

    # lib mkOverride 899 is one unit stronger than lib.mkDefault
    meta = {
      browser = lib.mkOverride 899 "firefox";
      terminal = lib.mkOverride 899 "kitty";
      fileManager = lib.mkOverride 899 "dolphin";
      editor = lib.mkOverride 899 "gnome-text-editor";
      imageViewer = lib.mkOverride 899 "gthumb";
      mediaPlayer = lib.mkOverride 899 "vlc";

      wallpaper = lib.mkDefault pkgs.images.default;
    };

    programs = {
      evince.enable = lib.mkDefault true;
      gnome-calculator.enable = lib.mkDefault true;
    };

    # battery notifier (gnome already has one)
    services = {
      batsignal.enable = lib.mkDefault (
        config.meta.desktop == "hyprland" || config.meta.desktop == "sway"
      );
      # use a graphical pinentry for gpg-agent
      gpg-agent.pinentry.package = lib.mkOverride 899 pkgs.pinentry-gnome3;
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
