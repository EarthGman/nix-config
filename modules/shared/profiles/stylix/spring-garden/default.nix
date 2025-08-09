{ lib, config, ... }:
let
  cfg = config.gman.profiles.stylix.spring-garden;
in
{
  options.gman.profiles.stylix.spring-garden.enable = lib.mkEnableOption "custom earthy colorscheme";

  config = lib.mkIf cfg.enable {
    stylix = {
      base16Scheme = ./colors.yaml;
      polarity = "dark";
    };
  };
}
