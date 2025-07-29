{ lib, config, ... }:
let
  inherit (lib)
    types
    mkIf
    mkForce
    mkOption
    mkEnableOption
    ;
  cfg = config.programs.firefox;
in
{
  options.programs.firefox = {
    imperativeConfig = mkEnableOption "imperative configuration for firefox";
  };

  config = mkIf cfg.imperativeConfig {
    programs.firefox.profiles = mkForce { };
  };
}
