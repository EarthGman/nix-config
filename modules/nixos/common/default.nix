{ hostname, lib, ... }:
let
  notVM = (hostname != "nixos");
in
{
  imports = [
    ./environment.nix
    ./1password.nix
    ./systempackages.nix
    ./nix.nix
    ./sound.nix
    ./sops.nix
    ./printing.nix
    ./xremap.nix
    ./udev.nix
  ] ++ (lib.optionals notVM [
    ./virtualization.nix
  ]);
}
