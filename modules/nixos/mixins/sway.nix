{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.gman.sway.enable = lib.mkEnableOption "gman's sway installation with uwsm";
  config = lib.mkIf config.gman.sway.enable {
    gman = {
      window-manager.enable = true;
      swww.enable = true;
    };
    services = {
      # notifications
      swaync.enable = true;
    };
    programs = {
      sway = {
        enable = true;
        extraPackages = builtins.attrValues {
          inherit (pkgs)
            # idle daemon
            swayidle

            # lockscreen
            swaylock-effects

            # the bar
            waybar

            # notifications
            swaynotificationcenter
            libnotify

            # clipboard
            wl-clipboard

            # screenshots
            grim
            # also needed for desktop portal wlr
            slurp
            ;
        };
      };
      uwsm = {
        enable = true;
        waylandCompositors = {
          sway = {
            prettyName = "Sway";
            comment = "sway compositor managed by UWSM";
            binPath = "${lib.getExe config.programs.sway.package}";
          };
        };
      };
      rofi.enable = true;
      # provide a terminal
      kitty.enable = lib.mkDefault true;
    };
  };
}
