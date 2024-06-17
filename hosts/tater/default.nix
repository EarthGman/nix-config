{
  imports = [
    inputs.disko.nixosModules.disko
    ./disko.nix
    ./users.nix
    ./boot.nix
    ./hardware.nix
    ./networking.nix
  ];
}
