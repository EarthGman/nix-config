{
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
    programs.hyprland = {
      enable = true;
      withUWSM = true;
    };
  };
}
