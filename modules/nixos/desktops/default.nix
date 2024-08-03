{ inputs, pkgs, lib, desktop, ... }:
let
  inherit (lib) optionals;
  inherit (builtins) elem filter isString split;
  # allows for a system to use multiple desktops at once
  desktops = filter isString (split "," desktop);
  gnome = elem "gnome" desktops;
  hyprland = elem "hyprland" desktops;
  plasma = elem "plasma" desktops;
  cinnamon = elem "cinnamon" desktops;
  i3 = elem "i3" desktops;

  resolvePlasmaGnome = (plasma && gnome);
  resolveCinnamonGnome = (cinnamon && gnome);
in
{
  imports =
    (optionals gnome [ ./gnome ]) ++
    (optionals hyprland [ ./hyprland ]) ++
    (optionals plasma [ ./plasma ]) ++
    (optionals cinnamon [ ./cinnamon ]) ++
    (optionals i3 [ ./i3 ]) ++

    (optionals resolvePlasmaGnome [ ./conflicts/plasma-gnome.nix ]) ++
    (optionals resolveCinnamonGnome [ ./conflicts/cinnamon-gnome.nix ]);

  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal
      ];
    };
  };
  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
  };
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };
}
