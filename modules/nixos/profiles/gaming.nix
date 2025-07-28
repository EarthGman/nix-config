{ lib, config, ... }:
let
  inherit (lib) mkDefault mkEnableOption mkIf;
  cfg = config.profiles.gaming;
in
{
  options.profiles.gaming.enable = mkEnableOption "gaming profile";
  config = mkIf cfg.enable {
    modules.steam.enable = true;
    programs = {
      # mouse control gui
      piper.enable = mkDefault true;
    };
  };
}
