{ lib, config, ... }:
let
  inherit (lib) mkDefault mkEnableOption mkIf;
  cfg = config.profiles.dunst.default;
in
{
  options.profiles.dunst.default.enable = mkEnableOption "default dunst profile";
  config = mkIf cfg.enable {
    stylix.targets.dunst.enable = true;
    services.dunst.settings = {
      global = {
        monitor = mkDefault 0;
        origin = mkDefault "bottom-right";
        timeout = mkDefault 3;
        frame_width = mkDefault 0;
        gap_size = mkDefault 3; # add small gap between notifications
        idle_threshold = mkDefault 30;
      };
    };
  };
}
