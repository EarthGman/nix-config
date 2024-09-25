{ wallpapers, ... }:
{
  stylix.image = builtins.fetchurl wallpapers.scarlet-tree-dark;
  stylix.colorScheme = "ashes";

  # just use default for now

  # programs = {
  #   waybar.theme = "ashes";
  # };
}
