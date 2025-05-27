{ lib, outputs, inputs, ... }:
let
  inherit (lib) autoImport;
  programs = autoImport ./programs;
  services = autoImport ./services;
in
{
  imports = [
    outputs.sharedModules
    inputs.stylix.homeModules.stylix
    ./stylix
    ./profiles
    ./desktops
    ./common
  ]
  ++ programs
  ++ services;
}
