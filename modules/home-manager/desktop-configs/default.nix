{ pkgs, desktop, lib, ... }:
let
  inherit (lib) optionals mkDefault;
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

  xdg.enable = true;

  # gtk apps have some missing icons if not set
  gtk.iconTheme = mkDefault {
    name = "Adwaita";
    package = pkgs.gnome.adwaita-icon-theme;
  };
}
