{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bottles
    winetricks
    wineWowPackages.staging
  ];
}
