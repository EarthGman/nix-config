{ pkgs ? import <nixpkgs> { } }: rec
{
  nordvpn = pkgs.callPackage ./nordvpn.nix;
}
