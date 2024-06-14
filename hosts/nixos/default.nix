{ inputs, ... }:
{
  imports = [
    inputs.disko.nixosModules.disko
    ./disko.nix
    ./boot.nix
    ./hardware.nix
    ./networking.nix
  ];
}
