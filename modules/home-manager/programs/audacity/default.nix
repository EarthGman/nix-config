{ pkgs, config, lib, ... }:
{
  options.custom.audacity.enable = lib.mkEnableOption "enable audacity";
  config = lib.mkIf config.custom.audacity.enable {
    home.packages = with pkgs; [
      audacity
    ];
  };
}
