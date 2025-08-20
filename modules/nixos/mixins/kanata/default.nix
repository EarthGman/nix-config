{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gman.kanata;
in
{
  options.gman.kanata.enable = lib.mkEnableOption "gman's personal keymap using kanata";
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
