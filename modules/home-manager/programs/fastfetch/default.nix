{ lib, config, ... }:
{
  options.custom.fastfetch.enable = lib.mkEnableOption "enable fastfetch";
  config = lib.mkIf config.custom.fastfetch.enable {
    programs.fastfetch = {
      #TODO rice
      enable = true;
    };
  };
}
