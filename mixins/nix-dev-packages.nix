{ pkgs, ... }:
builtins.attrValues {
  inherit (pkgs)
    nurl
    nix-prefetch-git
    deadnix
    nixpkgs-hammering
    statix
    nix-init
    nix-update
    nixpkgs-review
    nixfmt
    ;
}
