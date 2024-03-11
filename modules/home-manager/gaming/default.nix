{ pkgs, ... }:
{
  imports = [
    ./prismlauncher.nix
    ./steam.nix
    ./dolphin.nix
  ];
}
