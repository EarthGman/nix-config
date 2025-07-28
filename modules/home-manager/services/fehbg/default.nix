# service for setting the wallpaper with feh on xorg desktops
{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (lib)
    mkIf
    mkEnableOption
    mkOption
    types
    concatStringsSep
    mapAttrsToList
    getExe
    ;
  cfg = config.services.fehbg;
in
{
  options.services.fehbg = {
    enable = mkEnableOption "enable wallpaper service using feh";
    image = mkOption {
      description = ''
        path to the image file as a string
        if multiple monitors are specified they should be configured seperately
      '';
      type = types.str;
      default = "${config.custom.wallpaper}";
    };

    settings = {
      scale-mode = mkOption {
        description = ''
          scale mode for feh to use across all monitors
          if multiple monitors are specified they should be configured seperately under services.fehbg.settings.monitor
        '';
        type = types.str;
        default = "${config.stylix.imageScalingMode}";
      };
      monitors = mkOption {
        description = ''
          monitor configuration for feh
          defined as monitor number in x ("0") as attrset with image config for that monitor
        '';
        example = ''
          "0" = {
            image = "path to my wallpaper";
          };
          "1" = {
            image = "path to another wallpaper";
          };
        '';
        type = types.attrsOf (types.attrsOf types.str);
        default = { };
      };
    };

    slideshow = {
      enable = mkEnableOption "enable fehbg slideshow configuration";
      interval = mkOption {
        description = "interval in seconds in which the wallpapers should be switched";
        type = types.int;
        default = 600; # 10 minutes
      };
      images = mkOption {
        description = "list of images to include in the slideshow";
        type = types.listOf types.str;
        default = [ ];
      };
    };
  };

  config =
    let
      multi-monitor = monitors: ''
        feh --no-fehbg --bg-${cfg.settings.scale-mode} ${
          concatStringsSep " " (mapAttrsToList (monitor: settings: "${settings.image}") monitors)
        }
      '';

      script = pkgs.writeScript "fehbg.sh" ''
        #!${getExe pkgs.bash}

        ${
          if (cfg.slideshow.enable) then
            ''
              images=(${toString (concatStringsSep " " cfg.slideshow.images)})
              image_count=''${#images[@]}
              current_image=0

              set_wallpaper() {
                feh --no-fehbg --bg-fill ''${images[$1]}
              }

              set_wallpaper $current_image

              while true; do
                sleep ${toString cfg.slideshow.interval}
                current_image=$((($current_image + 1) % $image_count))
                set_wallpaper $current_image
              done
            ''
          else if cfg.settings.monitors != { } then
            ''
              ${multi-monitor cfg.settings.monitors}
            ''
          else
            ''
              feh --no-fehbg --bg-${cfg.settings.scale-mode} ${cfg.image}
            ''
        }
      '';
    in
    mkIf cfg.enable {
      stylix.targets.feh.enable = false; # prevent stylix from controlling feh
      programs.feh.enable = true;
      xsession.initExtra = ''
        systemctl --user start fehbg
      '';
      systemd.user.services.fehbg = {
        Service = {
          Type = "simple";
          ExecStart = "${script}";
        };
      };
    };
}
