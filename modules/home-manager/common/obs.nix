{ pkgs, config, lib, ... }:
{
  options.obs-studio.enable = lib.mkEnableOption "enable obs-studio";
  config = lib.mkIf config.obs-studio.enable {
    programs.obs-studio = {
      enable = true;
    };
  };
}
