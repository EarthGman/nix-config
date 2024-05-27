{ lib, desktop, ... }:
let
  desktops = builtins.filter builtins.isString (builtins.split "," desktop);
  gnome = lib.elem "gnome" desktops;
  hyprland = lib.elem "hyprland" desktops;
in
{
  imports = [ ] ++
    (lib.optionals gnome [ ./gnome ]) ++
    (lib.optionals hyprland [ ./hyprland ]);

  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
  };
}
