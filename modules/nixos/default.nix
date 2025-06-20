{ lib, inputs, ... }:
let
  inherit (lib) autoImport;
  programs = autoImport ./programs;
  services = autoImport ./services;
in
{
  imports = [
    inputs.disko.nixosModules.default
    ../shared
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
