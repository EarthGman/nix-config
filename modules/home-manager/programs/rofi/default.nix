{ lib, config, ... }:
let
  inherit (lib) mkEnableOption mkIf mkForce;
  cfg = config.programs.rofi;
in
{
  options.programs.rofi.imperativeConfig = mkEnableOption "imperative config for rofi";

  config = {
    programs.rofi = mkIf cfg.imperativeConfig {
      theme = mkForce null;
      extraConfig = mkForce { };
    };
  };
}
