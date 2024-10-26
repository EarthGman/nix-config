{ lib, config, ... }:
{
  options.modules.nh.enable = lib.mkEnableOption "enable custom nh module";
  config = lib.mkIf config.modules.nh.enable {
    programs.nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = lib.mkDefault "--keep-since 4d --keep 3";
    };
  };
}
