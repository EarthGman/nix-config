{ self, wallpapers, ... }:
let
  profile = self + /profiles/home-manager/essentials.nix;
in
{
  imports = [
    profile
  ];

  stylix.image = builtins.fetchurl wallpapers.scarlet-tree-dark;
}
