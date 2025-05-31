{ lib, config, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.profiles.firefox.default;
in
{
  options.profiles.firefox.default.enable = mkEnableOption "the default firefox profile";
  config = mkIf cfg.enable {
    programs.firefox.imperativeConfig = true;
  };
}
