{ desktop, lib, pkgs, ... }:
let
  inherit (lib) optionals;
  inherit (builtins) filter isString split elem;
  desktops = filter isString (split "," desktop);
  gnome = elem "gnome" desktops;
  hyprland = elem "hyprland" desktops;
  plasma = elem "plasma" desktops;
  cinnamon = elem "cinnamon" desktops;
  i3 = elem "i3" desktops;
in
{
  imports =
    (optionals gnome [ ./gnome ]) ++
    (optionals hyprland [ ./hyprland ]) ++
    (optionals plasma [ ./plasma ]) ++
    (optionals cinnamon [ ./cinnamon ]) ++
    (optionals i3 [ ./i3 ]);
}
