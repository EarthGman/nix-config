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
      dolphin-emu.enable = mkDefault true;
      # mouse control gui
      piper.enable = mkDefault true;
    };
  };
}
