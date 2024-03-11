{ pkgs, ... }:
{
  imports = [
    ./common.nix
    ./github.nix
    ./musescore.nix
  ];
}
