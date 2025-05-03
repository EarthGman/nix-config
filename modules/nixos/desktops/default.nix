{ lib, ... }@args:
let
  desktop = if args ? desktop then args.desktop else null;
  inherit (builtins) elem;
  desktops = if (desktop != null) then lib.splitString "," desktop else [ ];

  gnome = elem "gnome" desktops;
  i3 = elem "i3" desktops;
  sway = elem "sway" desktops;
  hyprland = elem "hyprland" desktops;
in
{
  imports = [
    ./gnome.nix
    ./i3.nix
    ./hyprland.nix
    ./sway.nix
  ];

  modules.desktops = {
    gnome.enable = gnome;
    i3.enable = i3;
    sway.enable = sway;
    hyprland.enable = hyprland;
  };
}
