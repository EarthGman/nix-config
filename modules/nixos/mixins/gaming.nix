{ lib, config, ... }:
let
  cfg = config.gman.gaming;
in
{
  options.gman.gaming.enable = lib.mkEnableOption "gman's gaming suite";
  config = lib.mkIf cfg.enable {
    gman.steam.enable = true;
    programs = {
      # mouse control gui
      piper.enable = lib.mkDefault true;
    };
  };
}
