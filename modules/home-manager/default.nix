{ lib, outputs, ... }:
let
  inherit (lib) autoImport;
  programs = autoImport ./programs;
  services = autoImport ./services;
  other = autoImport ./misc;
in
{
  imports = [
    outputs.sharedModules
    outputs.sharedProfiles.tmux
    ./stylix
    ./desktop-settings
  ] ++ (with outputs.homeProfiles; [
    default
    alacritty
    zsh
  ])
  ++ other
  ++ programs
  ++ services;
}
