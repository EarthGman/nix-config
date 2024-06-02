{ desktop, lib, ... }:
let
  desktops = builtins.filter builtins.isString (builtins.split "," desktop);
  gnome = builtins.elem "gnome" desktops;
  hyprland = builtins.elem "hyprland" desktops;
  plasma = builtins.elem "plasma" desktops;
  cinnamon = builtins.elem "cinnamon" desktops;

  resolvePlasmaGnome = (plasma && gnome);
  resolveCinnamonGnome = (cinnamon && gnome);
in
{
  imports =
    (lib.optionals gnome [ ./gnome ]) ++
    (lib.optionals hyprland [ ./hyprland ]) ++
    (lib.optionals plasma [ ./plasma ]) ++
    (lib.optionals cinnamon [ ./cinnamon ]) ++

    (lib.optionals resolvePlasmaGnome [ ./conflicts/plasma-gnome.nix ]) ++
    (lib.optionals resolveCinnamonGnome [ ./conflicts/cinnamon-gnome.nix ]);

  xdg.portal.enable = true;

  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
  };
}
