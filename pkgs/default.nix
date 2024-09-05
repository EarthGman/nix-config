{ pkgs, ... }:
{
  astronaut = pkgs.callPackage ./sddm-themes/astronaut.nix { };
  nixos = pkgs.callPackage ./grub-themes/nix.nix { };
}
