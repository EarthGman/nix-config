{ lib, ... }:
let
  inherit (lib) autoImport;
  other = autoImport ./misc;
  programs = autoImport ./programs;
  services = autoImport ./services;
in
{
  imports = [
    ./bootloaders
    ./desktops
    ./display-managers
    ./gpu
  ]
  ++ other
  ++ programs
  ++ services;
}
