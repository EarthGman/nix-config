# basic desktop modules
{ lib, desktop, ... }@args:
let
  desktop = if args ? desktop then args.desktop else null;
  inherit (lib) optionals splitString autoImport mkDefault;
  inherit (builtins) elem;
  desktops = if (desktop != null) then splitString "," desktop else [ ];
  i3 = elem "i3" desktops;
  sway = elem "sway" desktops;
  gnome = elem "gnome" desktops;
  hyprland = elem "hyprland" desktops;
in
{
  imports = autoImport ./.;
  profiles.desktops.gnome.default.enable = mkDefault gnome;
  xsession.windowManager.i3.enable = i3;
  wayland.windowManager = {
    sway.enable = sway;
    hyprland.enable = hyprland;
  };
}
