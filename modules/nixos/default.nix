{ lib, outputs, ... }:
let
  inherit (lib) autoImport;
  other = autoImport ./misc;
  programs = autoImport ./programs;
  services = autoImport ./services;
  profiles = autoImport ./profiles;
in
{
  imports = [
    outputs.sharedModules
    ./bootloaders
    ./desktops
    ./display-managers
    ./gpu
  ]
  ++ other
  ++ programs
  ++ services
  ++ profiles;
}
