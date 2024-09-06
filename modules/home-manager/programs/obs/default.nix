{ config, lib, ... }:
{
  options.custom.obs.enable = lib.mkEnableOption "enable obs-studio";
  config = lib.mkIf config.custom.obs.enable {
    programs.obs-studio = {
      enable = true;
    };
  };
}
