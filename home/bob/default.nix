{
  lib,
  config,
  hostName,
  ...
}:
{
  imports = [
    ../../hosts/${hostName}/users/bob/home-manager.nix
  ];

  gman = {
    suites.reddit-ricing.enable = true;
    suites.desktop-utilities.enable = true;
  };
}
