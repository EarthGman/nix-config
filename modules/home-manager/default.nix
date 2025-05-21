{ lib, outputs, ... }:
let
  inherit (lib) autoImport;
  programs = autoImport ./programs;
  services = autoImport ./services;
  other = autoImport ./misc;
  profiles = autoImport ./profiles;
in
{
  imports = [
    outputs.sharedModules
    ./stylix
    ./desktop-settings
  ]
  ++ other
  ++ programs
  ++ services
  ++ profiles;
}
