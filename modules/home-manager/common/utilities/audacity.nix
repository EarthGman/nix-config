{ pkgs, config, lib, ... }:
{
  options.audacity.enable = lib.mkEnableOption "enable audacity";
  config = lib.mkIf config.audacity.enable {
    home.packages = with pkgs; [
      audacity
    ];
  };
}
