{
  description = "2nd nix config attempt";
  outputs = inputs @ {self , nixpkgs, ...}:
  {
  nixosConfigurations.pav = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      ./configuration.nix
    ];
  };
  };
}