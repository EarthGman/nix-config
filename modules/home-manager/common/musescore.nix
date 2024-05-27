{ pkgs, config, lib, ... }:
{
  options.musescore.enable = lib.mkEnableOption "enable musescore";
  config = lib.mkIf config.musescore.enable {
    home.packages = with pkgs; [
      musescore
    ];
  };
}
