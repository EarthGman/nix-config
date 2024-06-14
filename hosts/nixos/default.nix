{ inputs, ... }:
{
  imports = [
    inputs.disko.nixosModules.disko
    ./disko.nix
    ./users
    ./boot.nix
    ./hardware.nix
    ./networking.nix
  ];
}
