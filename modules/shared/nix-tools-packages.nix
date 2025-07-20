# packages for the nix-tools profile
{ pkgs, ... }:
with pkgs;
[
  nurl
  nix-prefetch-git
  deadnix
  nixpkgs-hammering
  statix
  nix-init
  nix-update
  nixpkgs-review
]
