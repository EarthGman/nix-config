{ lib, outputs, inputs, ... }:
let
  inherit (lib) autoImport;
  programs = autoImport ./programs;
  services = autoImport ./services;
in
{
  imports = [
    inputs.disko.nixosModules.default
    outputs.sharedModules
    ./profiles
    ./bootloaders
    ./desktops
    ./display-managers
    ./gpu
    ./core
  ]
  ++ programs
  ++ services;
}
