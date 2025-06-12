{ lib, config, ... }:
let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.profiles.hyprlock.default;
in
{
  options.profiles.hyprlock.default.enable = mkEnableOption "default hyplock profile";
  config = mkIf cfg.enable { };
}
