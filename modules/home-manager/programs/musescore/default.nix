{ pkgs, config, lib, ... }:
{
  options.programs.musescore.enable = lib.mkEnableOption "enable musescore";
  config = lib.mkIf config.programs.musescore.enable {
    home.packages = with pkgs; [
      musescore
    ];
  };
}
