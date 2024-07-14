{ pkgs, ... }:
{
  imports = [
    ./fs.nix
  ];
  boot.loader.grub.theme = pkgs.grub-theme;
}
