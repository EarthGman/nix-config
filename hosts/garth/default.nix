{ pkgs, ... }:
{
  imports = [
    ./users
    ./hardware.nix
  ];
  boot.loader.grub.theme = pkgs.grub-theme;
}
