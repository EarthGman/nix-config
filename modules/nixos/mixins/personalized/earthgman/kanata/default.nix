{
  lib,
  config,
  ...
}:
let
  cfg = config.gman.personalized.earthgman.kanata;
in
{
  options.gman.personalized.earthgman.kanata.enable =
    lib.mkEnableOption "my personal keymap using kanata";
  config = lib.mkIf cfg.enable {
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
