{ config, pkgs, lib, ... }:
let
  cfg = config.custom.sunshine;
in
{
  options.custom.sunshine = {
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
