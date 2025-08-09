{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.services.sway-dynamic-tiling;
  ExecStart = import ./script.nix { inherit pkgs; };
in
{
  options.services.sway-dynamic-tiling.enable = lib.mkEnableOption "dynamic tiling in swaywm";
  config = lib.mkIf cfg.enable {
    warnings = lib.mkIf (!config.wayland.windowManager.sway.enable) [
      "services.sway-dynamic-tiling is enabled but sway is not."
    ];

    home.packages = [
      pkgs.coreutils-full
      pkgs.jq
    ];
    systemd.user.services."sway-dynamic-tiling" = {
      Unit = {
        Description = "dynamic window creation pattern for sway";
        After = [ "graphical-session.target" ];
        Wants = [ "graphical-session.target" ];
      };
      Service = {
        Environment = "PATH=${config.home.homeDirectory}/.nix-profile/bin";
        Type = "simple";
        ExecStartPre = "${lib.getExe pkgs.bash} -c 'while ! (swaymsg -t get_version >/dev/null 2>&1); do sleep 1; done'";
        inherit ExecStart;
        Restart = "no";
      };
      Install.WantedBy = [ "graphical-session.target" ];
    };
  };
}
