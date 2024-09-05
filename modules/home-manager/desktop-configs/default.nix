{ myLib, lib, desktop, ... }:
let
  inherit (lib) optionals;
  inherit (builtins) elem;
  desktops = myLib.splitToList desktop;
  i3 = elem "i3" desktops;
in
{
  imports = optionals i3 [ ./i3 ];
}
