{ pkgs, inputs, ... }:
let
  inherit (pkgs) callPackage system;
in
{
  nvim-vague = callPackage ./nvim-vague.nix { };
  blink-cmp = inputs.blink-cmp.packages.${system}.blink-cmp;
  direnv-nvim = callPackage ./direnv-nvim.nix { };
  lzn = inputs.lzn.packages.${system}.default;
  nvim-universal-clipboard = callPackage ./universal-clipboard.nix { };
}
