{ lib, ... }:
let
  inherit (lib) autoImport;
  other = autoImport ./misc;
  programs = autoImport ./programs;
in
{
  imports = [
    ./bootloaders
    ./desktops
    ./display-managers
    ./gpu
  ]
  ++ other
  ++ programs;
}
