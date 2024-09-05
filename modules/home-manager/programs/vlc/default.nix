{ pkgs, config, lib, ... }:
{
  options.custom.vlc.enable = lib.mkEnableOption "enable vlc";
  config = lib.mkIf config.custom.vlc.enable {
    home.packages = with pkgs; [
      vlc
    ];
  };
}
