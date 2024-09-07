# note while it is possible to enable multiple desktops at once it is highly unrecommended.
# any conflicts between 2 desktops are not supported
{ desktop, myLib, lib, ... }:
let
  inherit (builtins) elem;
  desktops = if (desktop != null) then myLib.splitToList desktop else [ ];

  gnome = elem "gnome" desktops;
  i3 = elem "i3" desktops;
in
{
  imports = [
    ./i3.nix
    ./gnome.nix
  ];

  custom = {
    gnome.enable = gnome;
    i3.enable = i3;
  };
}
