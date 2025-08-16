{ lib, hostname, ... }:
{
  imports = [ ../../hosts/${hostname}/users/Chris/home-manager.nix ];
}
