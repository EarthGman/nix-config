{ pkgs, config, lib, ... }:
{
  options.programs.audacity.enable = lib.mkEnableOption "enable audacity";
  config = lib.mkIf config.programs.audacity.enable {
    home.packages = with pkgs; [
      audacity
    ];
  };
}
