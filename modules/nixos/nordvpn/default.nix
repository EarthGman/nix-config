{ config, lib, pkgs, ... }:
{
  imports = [
    ./nordvpn.nix
  ];
  services.nordvpn.enable = true;
}
