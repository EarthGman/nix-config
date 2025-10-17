{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gman.gaming;
in
{
  options.gman.gaming = {
    enable = lib.mkEnableOption "gman's gaming PC configuration";
  };

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      {
        gman = {
          steam.enable = true;
          hardware-tools.enable = true;
        };
        programs = {
          lutris.enable = true;
        };
      }
    ]
  );
}
