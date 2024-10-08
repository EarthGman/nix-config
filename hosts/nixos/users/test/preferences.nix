{ self, wallpapers, ... }:
let
  template = self + /templates/home-manager/minimal-desktop.nix;
in
{
  imports = [
    template
  ];

  stylix.image = builtins.fetchurl wallpapers.scarlet-tree-dark;

  programs = {
    yazi.enable = true;
  };
}
