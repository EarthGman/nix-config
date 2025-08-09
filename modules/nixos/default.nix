{ inputs, lib, ... }:
let
  sharedModules = [ ../shared ];
in
{
  imports =
    lib.autoImport ./.
    ++ [
      inputs.disko.nixosModules.default
      inputs.determinate.nixosModules.default
      inputs.home-manager.nixosModules.default
      inputs.nix-gaming.nixosModules.pipewireLowLatency
      inputs.sops-nix.nixosModules.default
      inputs.stylix.nixosModules.stylix
    ]
    ++ sharedModules;
}
