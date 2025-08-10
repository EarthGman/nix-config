{
  lib,
  config,
  hostname,
  ...
}:
{
  imports = [
    ../../hosts/${hostname}/users/bob/home-manager.nix
  ];

  gman = {
    suites.reddit-ricing.enable = true;
    suites.desktop-utilities.enable = true;
  };
}
