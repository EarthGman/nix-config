{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gman.profiles.desktopThemes.the-world-machine;
in
{
  options.gman.profiles.desktopThemes.the-world-machine.enable =
    lib.mkEnableOption "gman's oneshot world machine theme";

  config = lib.mkIf cfg.enable {
    meta = {
      wallpaper = pkgs.images.the-world-machine;
      profiles.stylix = lib.mkForce "phosphor";
      profiles.rofi = "the-world-machine";
      profiles.waybar = "the-world-machine";
      profiles.conky = "the-world-machine";
    };

    gman.profiles.firefox.shyfox.config.wallpaper = lib.mkDefault pkgs.images.niko-roomba;

    stylix.icons = {
      dark = "star-pixel-icons";
      light = "star-pixel-icons";
      package = pkgs.star-pixel-icons;
    };

    stylix.fonts = {
      sansSerif = {
        name = "8\-bit Operator+";
        package = pkgs."8-bit-operator-font";
      };
      serif = {
        name = "Pixel Code";
        package = pkgs.pixel-code;
      };
      monospace = {
        name = "Pixel Code";
        package = pkgs.pixel-code;
      };
      emoji = {
        name = "8\-bit Operator+";
        package = pkgs."8-bit-operator-font";
      };

      sizes = {
        applications = lib.mkDefault 14;
        desktop = lib.mkDefault 12;
        popups = lib.mkDefault 14;
        terminal = lib.mkDefault 16;
      };
    };

    services.conky = {
      enable = lib.mkDefault true;
    };

    wayland.windowManager = {
      # restarting conky.service is weird af and this is somehow the smoothest way to do it
      # without doing this it is possible that systemd will take over a minute to load the window manager services
      sway.config.startup = [
        {
          command = "pkill --signal SIGKILL conky";
          always = true;
        }
      ];
      hyprland.settings.exec = [ "pkill --signal SIGKILL conky" ];
    };
  };
}
