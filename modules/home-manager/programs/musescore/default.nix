{ pkgs, config, lib, ... }:
{
  options.custom.musescore.enable = lib.mkEnableOption "enable musescore";
  config = lib.mkIf config.custom.musescore.enable {
    home.packages = with pkgs; [
      musescore
    ];
  };
}
