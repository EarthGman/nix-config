{ lib, config, ... }:
let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.profiles.alacritty.default;
in
{
  options.profiles.alacritty.default.enable = mkEnableOption "default alacritty profile";
  config = mkIf cfg.enable {
    stylix.targets.alacritty.enable = true;
  };
}
