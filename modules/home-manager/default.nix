{ lib, outputs, ... }:
let
  inherit (lib) autoImport;
  programs = autoImport ./programs;
  services = autoImport ./services;
  common = autoImport ./common;
  profiles = autoImport ./profiles;
in
{
  imports = [
    outputs.sharedModules
    ./stylix
    ./desktop-settings
  ]
  ++ common
  ++ programs
  ++ services
  ++ profiles;
}
