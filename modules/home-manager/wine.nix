{ pkgs, ... }:
# windows emulator
{
  home.packages = with pkgs; [
    winetricks
    wineWowPackages.stable
    #wineWowPackages.waylandFull
  ];
}
