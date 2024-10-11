{ self, wallpapers, ... }:
let
  profile = self + /profiles/home-manager/minimal.nix;
in
{
  imports = [
    profile
  ];

  stylix.image = builtins.fetchurl wallpapers.scarlet-tree-dark;

  programs = {
    yazi.enable = true;
  };
}
