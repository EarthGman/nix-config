{ pkgs, lib, config, ... }:
let
  inherit (lib) mkDefault mkIf mkEnableOption;
  cfg = config.profiles.swaylock.default;
in
{
  options.profiles.swaylock.default.enable = mkEnableOption " default swaylock profile";

  config = mkIf cfg.enable {
    stylix.targets.swaylock.enable = true;
    programs.swaylock = {
      package = mkDefault pkgs.swaylock-effects;
      settings = {
        effect-blur = mkDefault "33x1";
        clock = mkDefault true;
      };
    };
  };
}
