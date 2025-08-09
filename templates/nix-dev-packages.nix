{ pkgs, ... }:
builtins.attrValues {
  inherit (pkgs)
    nurl
    nix-prefetch-git
    nix-prefetch-url
    deadnix
    nixpkgs-hammering
    statix
    nix-init
    nix-update
    nixpkgs-rebiew
    ;
}
