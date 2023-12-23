{ pkgs, config, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      winetricks
      wineWowPackages.stable
      #wineWowPackages.waylandFull
    ];
  };
}
