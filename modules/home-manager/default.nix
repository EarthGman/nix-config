{ lib, outputs, ... }:
let
  inherit (lib) autoImport;
  programs = autoImport ./programs;
  services = autoImport ./services;
in
{
  imports = [
    outputs.sharedModules
    ./stylix
    ./profiles
    ./desktops
    ./common
  ]
  ++ programs
  ++ services;
}
