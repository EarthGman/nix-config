# service for setting the wallpaper with feh on xorg desktops
{ pkgs, lib, config, ... }:
let
  inherit (lib) mkIf mkEnableOption mkOption types concatStringsSep mapAttrsToList getExe;
  cfg = config.services.fehbg;

  multi-monitor = monitors: concatStringsSep "\n" (mapAttrsToList
    (monitor: settings: ''
      feh --no-fehbg --bg-${settings.scale-mode} --xinerama-index ${monitor} "${settings.image}"
    '')
    monitors);

  script = pkgs.writeScript "fehbg.sh" ''
    #!${getExe pkgs.bash}
    ${if cfg.settings.monitors == { } then ''
      feh --no-fehbg --bg-${cfg.settings.scale-mode} ${cfg.settings.image}
    ''
    else ''
      ${multi-monitor cfg.settings.monitors} 
    ''}
  '';
in
{
  options.services.fehbg = {
    enable = mkEnableOption "enable wallpaper service using feh";
    settings = {
      scale-mode = mkOption {
        description = ''
          scale mode for feh to use across all monitors
          if multiple monitors are specified they should be configured seperately under services.fehbg.settings.monitor
        '';
        type = types.str;
        default = "${config.stylix.imageScalingMode}";
      };
      image = mkOption {
        description = ''
          path to the image file as a string
          if multiple monitors are specified they should be configured seperately
        '';
        type = types.str;
        default = "${config.stylix.image}";
      };
      monitors = mkOption {
        description = ''
          monitor configuration for feh
          monitor number ("0") as attrset with 2 options: image and scale-mode
        '';
        type = types.attrsOf (types.attrsOf types.str);
        default = { };
      };
    };
  };

  #TODO: add slideshow maker
  config = mkIf cfg.enable {
    stylix.targets.feh.enable = false; # prevent stylix from controlling feh
    programs.feh.enable = true;
    xsession.initExtra = ''
      systemctl --user start fehbg
    '';
    systemd.user.services.fehbg = {
      Service = {
        Type = "oneshot";
        ExecStart = "${script}";
      };
    };
  };
}
