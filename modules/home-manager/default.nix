{ lib, ... }:
let
  inherit (lib) autoImport;
  programs = autoImport ./programs;
  services = autoImport ./services;
  shared = autoImport ./shared;
in
{
  imports = [
    ./stylix
    ./desktop-settings
  ]
  ++ shared
  ++ programs
  ++ services;
}
