{ lib, config, ... }:
let
  inherit (lib) mkOption mkEnableOption types;
in
{
  options.xsession = {
    screensaver = {
      enable = mkEnableOption "enable basic screensaver for xorg";
      timeout = mkOption {
        description = "time in seconds until timeout";
        type = types.int;
        default = 600;
      };
      cycle = mkOption {
        description = "update interval for certain screensaver features such as moving images";
        type = types.int;
        default = 0;
      };
      preferBlanking = mkOption {
        description = "forces a black screen when the screensaver is activated";
        type = types.bool;
        default = true;
      };
      allowExposures = mkOption {
        description = ''
          allows for the screen to refresh incrementally as windows are redrawn.
          Useful for environments where redrawing time is short or not noticeable.
        '';
        type = types.bool;
        default = true;
      };
    };
    dpms = {
      enable = mkEnableOption "enable dpms, a screensaving feature for xorg";
      standby = mkOption {
        description = "time in seconds until dpms standby activation";
        type = types.int;
        default = 600;
      };
      suspend = mkOption {
        description = "time in seconds until dpms suspend activation";
        type = types.int;
        default = 600;
      };
      off = mkOption {
        description = "time in seconds until dpms powers off the monitors";
        type = types.int;
        default = 600;
      };
    };
  };

  config = {
    xsession = let cfg = config.xsession; in {
      initExtra = ''
        systemctl --user import-environment XDG_CURRENT_DESKTOP PATH
      '';
      profileExtra = (if cfg.dpms.enable then ''
        xset +dpms
        xset dpms ${toString cfg.dpms.standby} ${toString cfg.dpms.suspend} ${toString cfg.dpms.poweroff}
      '' else ''
        xset -dpms
      '') + (if cfg.screensaver.enable then ''
        xset s on
        xset s ${if cfg.screensaver.preferBlanking then "blank" else "noblank"}
        xset s ${if cfg.screensaver.allowExposures then "expose" else "noexpose"}
        xset s ${toString cfg.screensaver.timeout} ${toString cfg.screensaver.cycle}
      '' else ''
        xset s off
      '');
    };
  };
}
