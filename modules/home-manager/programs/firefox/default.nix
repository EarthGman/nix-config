{ lib, config, ... }:
let
  inherit (lib) types mkIf mkForce mkOption mkEnableOption;
  cfg = config.programs.firefox;
in
{
  options.programs.firefox = {
    themes = {
      shyfox.config = mkOption {
        description = ''
          any extra configuration for the shyfox theme.
        '';
        default = { };
        type = types.attrsOf types.str;
      };
    };
    imperativeConfig = mkEnableOption "imperative configuration for firefox";
  };

  config = mkIf cfg.imperativeConfig {
    programs.firefox.profiles = mkForce { };
  };
}
