{ lib, inputs, ... }:
let
  inherit (lib) autoImport;
  programs = autoImport ./programs;
  services = autoImport ./services;
in
{
  imports =
    [
      inputs.disko.nixosModules.default
      inputs.determinate.nixosModules.default
      inputs.nix-gaming.nixosModules.pipewireLowLatency
      inputs.home-manager.nixosModules.default
      inputs.sops-nix.nixosModules.sops
      # inputs.jovian-nixos.nixosModules.default

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
