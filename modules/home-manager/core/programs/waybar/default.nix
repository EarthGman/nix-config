{ lib, config, ... }:
let
  cfg = config.programs.waybar;
in
{
  options.programs.waybar.imperativeConfig = lib.mkEnableOption "imperative config for waybar";

  config = lib.mkIf cfg.imperativeConfig {
    programs.waybar.settings = lib.mkForce [ ];
  };
}
