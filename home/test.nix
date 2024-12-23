{ self, wallpapers, ... }:
let
  profile = self + /profiles/home-manager/essentials.nix;
in
{
  imports = [
    profile
  ];
  custom.fileManager = "yazi";

  stylix.image = builtins.fetchurl wallpapers.scarlet-tree-dark;
}
