# note while it is possible to enable multiple desktops at once it is highly unrecommended.
# any conflicts between 2 desktops are not supported
{ desktop, myLib, ... }:
let
  inherit (builtins) elem;
  desktops = myLib.splitToList desktop;

  gnome = elem "gnome" desktops;
  plasma = elem "plasma" desktops;
  cinnamon = elem "cinnamon" desktops;
  i3 = elem "i3" desktops;
in
{
  imports = [
    ./i3.nix
    # ./gnome.nix
    # ./plasma.nix
    # ./cinnamon.nix
  ];

  custom = {
    # gnome.enable = gnome;
    # plasma.enable = plasma;
    # cinnamon.enable = cinnamon;
    i3.enable = i3;
  };
}
