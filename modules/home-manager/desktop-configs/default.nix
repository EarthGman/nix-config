{ desktop, lib, pkgs, ... }:
let
  desktops = builtins.filter builtins.isString (builtins.split "," desktop);
  gnome = builtins.elem "gnome" desktops;
  hyprland = builtins.elem "hyprland" desktops;
  plasma = builtins.elem "plasma" desktops;
in
{
  imports =
    (lib.optionals gnome [ ./gnome ]) ++
    (lib.optionals hyprland [ ./hyprland ]) ++
    (lib.optionals plasma [ ./plasma ]);
}
