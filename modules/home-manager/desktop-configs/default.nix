{ desktop, lib, pkgs, ... }:
let
  desktops = builtins.filter builtins.isString (builtins.split "," desktop);
  gnome = builtins.elem "gnome" desktops;
  hyprland = builtins.elem "hyprland" desktops;
in
{
  imports =
    (lib.optionals gnome [ ./gnome ]) ++
    (lib.optionals hyprland [ ./hyprland ]);
}
