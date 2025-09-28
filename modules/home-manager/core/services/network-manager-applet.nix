{
  pkgs,
  lib,
  config,
  ...
}:
# TODO check or request that home-manager install the package to home.packages when service is enabled
# fix networkmanagerapplet icon bug
{
  home.packages = lib.mkIf (config.services.network-manager-applet.enable) [
    pkgs.networkmanagerapplet
  ];
}
