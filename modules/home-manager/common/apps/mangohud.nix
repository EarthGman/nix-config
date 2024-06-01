{ pkgs, config, lib, ... }:
{
  options.mangohud.enable = lib.mkEnableOption "enable mangohud";
  config = lib.mkIf config.mangohud.enable {
    home.packages = with pkgs; [
      mangohud
    ];
  };
}
