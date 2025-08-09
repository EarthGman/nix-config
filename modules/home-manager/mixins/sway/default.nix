# shared config between sway and i3
{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gman.sway;
in
{
  options.gman.sway.enable = lib.mkEnableOption "gman's sway config";
  config = lib.mkIf cfg.enable {
    wayland.windowManager.sway = {
      enable = true;
      systemd.enable = false;
      config = import ./settings.nix {
        inherit pkgs lib config;
      };
    };

    stylix.targets = {
      sway.enable = true;
      swaylock.enable = true;
    };

    programs = {
      rofi.enable = lib.mkDefault true;
      waybar.enable = lib.mkDefault true;
      swaylock = {
        enable = lib.mkDefault true;
        package = lib.mkDefault pkgs.swaylock-effects;
        settings = {
          effect-blur = lib.mkDefault "33x1";
          clock = lib.mkDefault true;
          image = lib.mkDefault config.meta.wallpaper;
        };
      };
    };

    services = {
      swaync.enable = lib.mkDefault true;
      sway-dynamic-tiling.enable = lib.mkDefault true;
      polkit-gnome.enable = lib.mkDefault true;
      swww.enable = lib.mkDefault true;

      swayidle = {
        enable = lib.mkDefault true;
        swaylock = {
          before-sleep = true;
          on-bat.timeout = lib.mkDefault 150;
        };
        dpms = {
          on-bat.timeout = lib.mkDefault 150;
        };
        suspend = {
          on-bat.timeout = lib.mkDefault 600;
        };
      };
    };
  };
}
