{ lib, config, ... }:
let
  cfg = config.gman.profiles.stylix.ashes;
in
{
  options.gman.profiles.stylix.ashes.enable =
    lib.mkEnableOption "gman's slight mod of the ashes colorscheme";

  config = lib.mkIf cfg.enable {
    stylix = {
      base16Scheme = ./colors.yaml;
      polarity = "dark";
    };
  };
}
