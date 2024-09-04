{ pkgs, ... }:
{
  astronaut = pkgs.callPackage ./sddm-themes/astronaut.nix { };
}
