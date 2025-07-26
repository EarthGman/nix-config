{
  lib,
  config,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.profiles.gman.kanata-keymap;
in
{
  options.profiles.gman.kanata-keymap.enable = mkEnableOption "my personal keymap using kanata";
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
