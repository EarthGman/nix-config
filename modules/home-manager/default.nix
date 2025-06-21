{ lib, inputs, ... }:
let
  inherit (lib) autoImport;
  programs = autoImport ./programs;
  services = autoImport ./services;
in
{
  imports = [
    inputs.stylix.homeModules.stylix
    inputs.sops-nix.homeManagerModules.sops
    ../shared
    ./stylix
    ./profiles
    ./desktops
    ./common
  ]
  ++ programs
  ++ services;
}
