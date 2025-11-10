{ lib, config, ... }:
let
  cfg = config.gman.profiles.stylix.phosphor;
in
{
  options.gman.profiles.stylix.phosphor.enable = lib.mkEnableOption "stylix oneshot colorscheme";

  config = lib.mkIf cfg.enable {
    stylix = {
      base16Scheme = ./colors.yaml;
      polarity = "dark";
    };
  };
}
