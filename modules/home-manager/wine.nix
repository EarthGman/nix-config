{ pkgs, ... }:
{
  home.packages = with pkgs; [
    winetricks
    wineWowPackages.stable
    #wineWowPackages.waylandFull
  ];
}
