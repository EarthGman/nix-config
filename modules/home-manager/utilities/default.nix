{ pkgs, ... }:
{
  imports = [
    ./common.nix
    ./github.nix
    ./musescore.nix
    ./gpg.nix
    ./looking-glass.nix
  ];
}
