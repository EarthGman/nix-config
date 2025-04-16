{ lib, ... }:
let
  inherit (lib) autoImport;
  other = autoImport ./misc;
in
{
  imports = [
    ./bootloaders
    ./desktops
    ./display-managers
    ./gpu
  ] ++ other;
}
