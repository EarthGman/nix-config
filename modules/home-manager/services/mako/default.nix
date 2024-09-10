{ lib, config, ... }:
{
  options.custom.mako.enable = lib.mkEnableOption "enable make a wayland notification daemon";
  config = lib.mkIf config.custom.mako.enable {
    services.mako = {
      enable = true;
    };
  };
}
