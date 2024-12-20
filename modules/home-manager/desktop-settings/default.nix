{ lib, desktop, ... }:
let
  inherit (lib) optionals mkDefault mkIf;
  inherit (builtins) elem;
  desktops = if (desktop != null) then lib.splitString "," desktop else [ ];
  i3 = elem "i3" desktops;
  sway = elem "sway" desktops;
  gnome = elem "gnome" desktops;
  hyprland = elem "hyprland" desktops;
in
{
  imports = optionals gnome [ ./gnome ]
    ++ optionals hyprland [ ./hyprland ]
    ++ optionals i3 [ ./i3 ]
    ++ optionals sway [ ./sway ];
}
