{ self, outputs, ... }:
let
  template = self + /templates/home-manager/minimal-desktop.nix;
in
{
  imports = [
    template
  ];

  stylix.image = outputs.wallpapers.scarlet-tree-dark;
}
