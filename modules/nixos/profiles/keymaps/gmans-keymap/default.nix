{
  lib,
  config,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.profiles.gmans-keymap;
in
{
  options.profiles.gmans-keymap.enable = mkEnableOption "my personal keymap";
  config = mkIf cfg.enable {
    services.kanata = {
      enable = true;
      keyboards = {
        default = {
          extraDefCfg = "process-unmapped-keys yes";
          config = builtins.readFile ./config.kbd;
        };
      };
    };
  };
}
