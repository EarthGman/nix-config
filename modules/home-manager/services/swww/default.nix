{ inputs, pkgs, lib, config, platform, ... }:
let
  inherit (lib) mkEnableOption mkOption mkIf types getExe;
  cfg = config.services.swww;
in
{
  options.services.swww = {
    enable = mkEnableOption ''
      enable swww, a solution to your wayland wallpaper woes
      (and the cause of mine)
    '';

    package = mkOption {
      description = "swww package to use";
      type = types.package;
      default = inputs.swww.packages.${platform}.swww;
    };

    image = mkOption {
      description = "the default image swww will use (applied to all monitors) as a string";
      type = types.str;
      default = "${config.stylix.image}";
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

    systemd.user.services =
      let
        bash = "${getExe pkgs.bash}";
        set-wallpaper = pkgs.writeScript "swww.sh" ''
          #!${bash}
          swww img ${cfg.image}
        '';
      in
      {
        swww-daemon = {
          Service = {
            Type = "exec";
            Environment = "PATH=/run/current-system/sw/bin:${config.home.homeDirectory}/.nix-profile/bin";
            ExecStart = "${bash} -c 'pgrep -x swww-daemon || swww-daemon --no-cache'";
            ExecStartPost = ''
              ${bash} -c '${if (config.services.omori-calendar-project.enable) then
                "sleep 0.2 && systemctl --user start omori-calendar-project"
              else
                "sleep 0.2 && systemctl --user start swww-wallpaper"}'
            '';
            ExecReload = "swww kill";
            KillSignal = "SIGTERM";
            Restart = "on-failure";
          };

          Unit = {
            Description = "start the swww-daemon";
            PartOf = [ "graphical-session.target" ];
            After = [ "graphical-session.target" ];
            # only trigger if in wayland session
            ConditionPathExistsGlob = "/run/user/%U/wayland-*";
          };

          Install = {
            WantedBy = [ "graphical-session.target" ];
          };
        };

        swww-wallpaper = {
          Service = {
            Type = "oneshot";
            Environment = "PATH=/run/current-system/sw/bin:${config.home.homeDirectory}/.nix-profile/bin";
            ExecStart = "${set-wallpaper}";
          };
          Unit = {
            Description = "Set wallpaper using swww";
          };
        };
      };
  };
}

