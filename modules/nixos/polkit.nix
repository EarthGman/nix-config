{ config, lib, ... }:
{
  options.custom.polkit.enable = lib.mkEnableOption "enable polkit";
  config = lib.mkIf config.custom.polkit.enable {
    security.polkit = {
      enable = true;
      debug = true;
    };
  };
}
