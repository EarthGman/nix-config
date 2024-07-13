{ pkgs, ... }:
{
  imports = [
    ./hardware.nix
    ./disko.nix
  ];
  boot.loader.grub.theme = pkgs.grub-theme;
}
