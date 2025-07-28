{ lib, config, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.profiles.bat.default;
in
{
  options.profiles.bat.default.enable = mkEnableOption "default bat profile";
  config = mkIf cfg.enable {
    stylix.targets.bat.enable = true;
  };
}
