{ lib, outputs, ... }:
let
  inherit (lib) autoImport;
  other = autoImport ./misc;
  programs = autoImport ./programs;
in
{
  imports = [
    outputs.nixosProfiles.default
    outputs.sharedModules
    ./bootloaders
    ./desktops
    ./display-managers
    ./gpu
  ]
  ++ other
  ++ programs;
}
