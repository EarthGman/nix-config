{ lib, config, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.profiles.eww.default;
in
{
  options.profiles.eww.default.enable = mkEnableOption "the default eww config";
  config = mkIf cfg.enable { };
}
