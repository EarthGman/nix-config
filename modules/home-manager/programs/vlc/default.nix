{ pkgs, config, lib, ... }:
{
  options.programs.vlc.enable = lib.mkEnableOption "enable vlc";
  config = lib.mkIf config.programs.vlc.enable {
    home.packages = with pkgs; [
      vlc
    ];
  };
}
