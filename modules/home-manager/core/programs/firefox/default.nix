{ lib, config, ... }:
let
  cfg = config.programs.firefox;
in
{
  options.programs.firefox.imperativeConfig = lib.mkEnableOption "imperative config for firefox";

  config = lib.mkIf cfg.imperativeConfig {
    programs.firefox.profiles = lib.mkForce { };
  };
}
