{ lib, config, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.profiles.starship.default;
in
{
  options.profiles.starship.default.enable = mkEnableOption "default starship profile";
  config = mkIf cfg.enable {
    stylix.targets.starship.enable = true;
  };
}
