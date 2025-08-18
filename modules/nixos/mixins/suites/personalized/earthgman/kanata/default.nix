{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gman.suites.personalized.earthgman.kanata;
in
{
  options.gman.suites.personalized.earthgman.kanata.enable =
    lib.mkEnableOption "my personal keymap using kanata";
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.kanata ];
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
