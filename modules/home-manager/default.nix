{ lib, outputs, ... }:
let
  inherit (lib) autoImport;
  programs = autoImport ./programs;
  services = autoImport ./services;
  other = autoImport ./misc;
in
{
  imports = [
    outputs.homeProfiles.default
    outputs.sharedModules
    outputs.sharedProfiles.tmux
    ./stylix
    ./desktop-settings
  ]
  ++ other
  ++ programs
  ++ services;
}
