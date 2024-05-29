{ desktop, lib, ... }:
let
  desktops = builtins.filter builtins.isString (builtins.split "," desktop);
  gnome = builtins.elem "gnome" desktops;
  hyprland = builtins.elem "hyprland" desktops;
  plasma = builtins.elem "plasma" desktops;
  cinnamon = builtins.elem "cinnamon" desktops;

  resolvePlasmaGnome = if (plasma && gnome) then true else false;
  resolveCinnamonGnome = if (cinnamon && gnome) then true else false;
in
{
  imports =
    (lib.optionals gnome [ ./gnome ]) ++
    (lib.optionals hyprland [ ./hyprland ]) ++
    (lib.optionals plasma [ ./plasma ]) ++
    (lib.optionals cinnamon [ ./cinnamon ]) ++

    (lib.optionals resolvePlasmaGnome [ ./conflicts/plasma-gnome.nix ]) ++
    (lib.optionals resolveCinnamonGnome [ ./conflicts/cinnamon-gnome.nix ]);

  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
  };
}
