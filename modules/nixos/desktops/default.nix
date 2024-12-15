{ desktop, lib, ... }:
let
  inherit (builtins) elem;
  desktops = if (desktop != null) then lib.splitString "," desktop else [ ];

  gnome = elem "gnome" desktops;
  i3 = elem "i3" desktops;
  hyprland = elem "hyprland" desktops;
in
{
  imports = [
    ./gnome.nix
    ./i3.nix
    ./hyprland.nix
  ];

  modules.desktops = {
    gnome.enable = gnome;
    i3.enable = i3;
    hyprland.enable = hyprland;
  };
}
