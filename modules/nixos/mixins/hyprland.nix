{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gman.hyprland;
in
{
  options.gman.hyprland.enable = lib.mkEnableOption "hyprland with uwsm";

  config = lib.mkIf cfg.enable {
    gman = {
      window-manager.enable = true;
      swww.enable = true;
    };

    programs = {
      hyprland = {
        enable = true;
        withUWSM = true;
      };
      hyprlock.enable = true;
      rofi.enable = lib.mkDefault true;
      kitty.enable = lib.mkDefault true;
    };

    services = {
      swaync.enable = true;
      hypridle.enable = true;
    };

    xdg.portal = {
      wlr.enable = true;
      config.hyprland = {
        default = [
          "wlr"
          "gtk"
          "hyprland"
        ];
      };
    };

    environment.systemPackages = builtins.attrValues {
      inherit (pkgs)
        waybar
        libnotify
        wl-clipboard
        grim
        slurp
        # screenshot script
        grimblast
        # graphical prompt for sudo / other polkit rules
        hyprpolkitagent
        ;
    };
  };
}
