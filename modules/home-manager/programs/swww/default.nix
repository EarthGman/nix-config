{ inputs, lib, config, platform, ... }:
let
  inherit (lib) mkEnableOption mkOption mkIf types;
  cfg = config.programs.swww;
in
{
  options.programs.swww = {
    enable = mkEnableOption "enable swww, a solution to your wayland wallpaper woes";
    package = mkOption {
      description = "package to use";
      type = types.package;
      default = inputs.swww.packages.${platform}.swww;
    };
    settings = {
      resizeMode = mkOption {
        description = "the resize mode for swww to use";
        type = types.str;
        default = "crop";
      };
      transition = {
        type = mkOption {
          description = "transition mode";
          type = types.str;
          default = "fade";
        };
        step = mkOption {
          description = "how fast the transition approaches the new image";
          type = types.int;
          default = 90;
        };
        duration = mkOption {
          description = "transition duration in seconds";
          type = types.int;
          default = 2;
        };
        fps = mkOption {
          description = "transition fps";
          type = types.int;
          default = 30;
        };
        angle = mkOption {
          description = "used for wipe and wave transitions. Rotation of the transition in degrees";
          type = types.int;
          default = 45;
        };
        pos = mkOption {
          description = "used for grow, outer. Controls the center of the circle";
          type = types.str;
          default = "center";
        };
        wave = mkOption {
          description = "only used for the wave transition to control the width and height of each wave";
          type = types.str;
          default = "20,20";
        };
      };
      invertY = mkOption {
        description = "inverts the y position sent in transition_pos";
        type = types.str;
        default = "false";
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];

    home.sessionVariables = {
      "SWWW_TRANSITION" = cfg.settings.transition.type;
      "SWWW_TRANSITION_STEP" = cfg.settings.transition.step;
      "SWWW_TRANSITION_DURATION" = cfg.settings.transition.duration;
      "SWWW_TRANSITION_FPS" = cfg.settings.transition.fps;
      "SWWW_TRANSITION_ANGLE" = cfg.settings.transition.angle;
      "SWWW_TRANSITION_POS" = cfg.settings.transition.pos;
      "INVERT_Y" = cfg.settings.invertY;
      "SWWW_TRANSITION_WAVE" = cfg.settings.transition.wave;
    };
  };
}

