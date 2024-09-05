{ pkgs, ... }:
let
  inherit (pkgs) callPackage;
in
{
  astronaut = callPackage ./sddm-themes/astronaut.nix { };
  nixos = callPackage ./grub-themes/nixos.nix { };
  nordvpn = callPackage ./nordvpn.nix { };
  tilingshell = callPackage ./tilingshell.nix { };
  userchrome-toggle-extended = callPackage ./uct-extended.nix { };
  shyfox = callPackage ./firefox-themes/shyfox.nix { };
}
