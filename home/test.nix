{ wallpapers, ... }:
{
  custom.fileManager = "yazi";

  stylix.image = builtins.fetchurl wallpapers.scarlet-tree-dark;
}
