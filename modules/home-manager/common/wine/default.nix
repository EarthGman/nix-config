{ pkgs, config, lib, ... }:
{
  options.wine.enable = lib.mkEnableOption "enable wine";
  config = lib.mkIf config.wine.enable {
    home.packages = with pkgs; [
      bottles
      winetricks
      wineWowPackages.staging
    ];
  };
}
