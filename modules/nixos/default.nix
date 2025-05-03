{ lib, outputs, ... }:
let
  inherit (lib) autoImport;
  other = autoImport ./misc;
  programs = autoImport ./programs;
  services = autoImport ./services;
in
{
  imports = [
    outputs.sharedModules
    outputs.sharedProfiles.tmux
    ./bootloaders
    ./desktops
    ./display-managers
    ./gpu
  ] ++ (with outputs.nixosProfiles; [
    default
    zsh
  ])
  ++ other
  ++ programs
  ++ services;
}
