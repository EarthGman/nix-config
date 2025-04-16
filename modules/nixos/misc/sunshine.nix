{ config, lib, ... }:
let
  cfg = config.modules.sunshine;
in
{
  options.modules.sunshine = {
    enable = lib.mkEnableOption "enable sunshine module";
  };
  config = lib.mkIf cfg.enable {
    services.sunshine = {
      enable = true;
      openFirewall = true;
      capSysAdmin = true;
    };
  };
}
