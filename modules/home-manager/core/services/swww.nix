{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.services.swww;
in
{
  options.services.swww = {
    image = lib.mkOption {
      description = "the default image swww will use (applied to all monitors) as a string";
      type = lib.types.str;
      default = "${config.meta.wallpaper}";
    };

    monitors = lib.mkOption {
      description = ''
        image configuration for multi monitor setups (nullifies cfg.image)
        monitor outputs should be configured based on channel found through
        hyprctl monitors or swaymsg -t get_outputs
      '';
      type = lib.types.attrsOf (lib.types.attrsOf lib.types.str);
      default = { };
      example = ''
        DP1 = {
          image = "path to wallpaper";
        };
        HDMI-A-0 = {
          image = "path to wallpaper";
        };
      '';
    };

    slideshow = {
      enable = lib.mkEnableOption "enable slideshow functionality with swww";
      interval = lib.mkOption {
        description = "interval in which the slideshow changes images specified in seconds";
        type = lib.types.int;
        default = 600;
      };
      images = lib.mkOption {
        description = "list of image paths to be included in the slideshow (as nix derivations)";
        type = lib.types.listOf lib.types.package;
        default = [ ];
      };
    };

    settings = {
      resizeMode = lib.mkOption {
        description = "the resize mode for swww to use";
        type = lib.types.str;
        default = "crop";
      };

      transition = {
        type = lib.mkOption {
          description = "transition mode";
          type = lib.types.str;
          default = "fade";
        };

        step = lib.mkOption {
          description = "how fast the transition approaches the new image";
          type = lib.types.int;
          default = 90;
        };

        duration = lib.mkOption {
          description = "transition duration in seconds";
          type = lib.types.int;
          default = 2;
        };

        fps = lib.mkOption {
          description = "transition fps";
          type = lib.types.int;
          default = 30;
        };

        angle = lib.mkOption {
          description = "used for wipe and wave transitions. Rotation of the transition in degrees";
          type = lib.types.int;
          default = 45;
        };

        pos = lib.mkOption {
          description = "used for grow, outer. Controls the center of the circle";
          type = lib.types.str;
          default = "center";
        };

        wave = lib.mkOption {
          description = "only used for the wave transition to control the width and height of each wave";
          type = lib.types.str;
          default = "20,20";
        };
      };

      invertY = lib.mkOption {
        description = "inverts the y position sent in transition_pos";
        type = lib.types.str;
        default = "false";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.coreutils-full
    ];

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
        multi-monitor = monitors: ''
          ${
            lib.concatStringsSep "\n" (
              lib.mapAttrsToList (monitor: settings: "swww img -o ${monitor} ${settings.image}") monitors
            )
          }  
        '';

        daemon-postup = pkgs.writeShellScript "swww-daemon-postup.sh" ''
          socket_path="$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY-swww-daemon..sock"

          for (( i=1; i<=30; i++ )); do
            if [ -e "$socket_path" ]; then
              ${pkgs.systemd}/bin/systemctl --user restart swww-wallpaper-manager
              exit 0
            fi
            sleep 0.1
          done
        '';

        set-wallpaper = pkgs.writeShellScript "swww.sh" ''
          ${
            if cfg.monitors != { } then
              ''
                ${multi-monitor cfg.monitors}
              ''
            else if (cfg.slideshow.enable) then
              ''
                images=(${toString (lib.concatStringsSep " " cfg.slideshow.images)})
                image_count=''${#images[@]}
                current_image=0

                set_wallpaper() {
                  swww img ''${images[$1]}
                }

                set_wallpaper $current_image

                while true; do
                  sleep ${toString cfg.slideshow.interval}
                  current_image=$(($current_image + 1))
                  if [ "$current_image" -eq "$image_count" ]; then
                    ${pkgs.systemd}/bin/systemctl --user restart swww
                    exit 0
                  fi

                  set_wallpaper $current_image
                done
              ''
            else
              ''
                swww img ${cfg.image}
              ''
          }
        '';
      in
      {
        swww.Service = {
          # Incorporate the HM service with my addons
          # forces argb by default
          ExecStart = lib.mkForce "${cfg.package}/bin/swww-daemon -f argb";
          ExecStartPost = "${daemon-postup}";
          Environment = "PATH=${config.home.homeDirectory}/.nix-profile/bin";
        };

        # kind of hacky but eh it works I guess
        swww-wallpaper-manager = {
          Service = {
            Type = "simple";
            Environment = "PATH=${config.home.homeDirectory}/.nix-profile/bin";
            ExecStart =
              if config.services.omori-calendar-project.enable then
                "${pkgs.systemd}/bin/systemctl --user restart omori-calendar-project"
              else
                "${set-wallpaper}";
          };
          Unit = {
            Description = "automatic wallpaper manager for swww";
          };
        };
      };
  };
}
