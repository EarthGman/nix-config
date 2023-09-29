{
  description = "2nd nix config attempt";
  outputs = inputs @ {self , nixpkgs, ...}:
  {
  nixosConfigurations.potato = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      ./machines/potato/configuration.nix
    ];
  };
  };
}