{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.gman.sway.enable = lib.mkEnableOption "gman's sway installation with uwsm";
  config = lib.mkIf config.gman.sway.enable {
    programs = {
      sway = {
        enable = true;
        extraPackages = [ ];
      };
      uwsm = {
        enable = true;
        waylandCompositors = {
          sway = {
            prettyName = "Sway";
            comment = "sway compositor managed by UWSM";
            binPath = "${lib.getExe pkgs.sway}";
          };
        };
      };
    };
  };
}
