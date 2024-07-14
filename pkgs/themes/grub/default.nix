{ pkgs, ... }:
{
  nixos = pkgs.callPackage ./nixos { };
}
