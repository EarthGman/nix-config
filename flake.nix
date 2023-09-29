{

  description = "Gman's nix config";

   inputs = {
    nur.url = "github:nix-community/NUR";
  };

  outputs = inputs @ {self , nixpkgs, home-manager, nur, ...}:
  {
    nixosConfigurations.potato = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
       modules = let
            nur-modules = import nur rec {
              nurpkgs = nixpkgs.legacyPackages.x86_64-linux;
              pkgs = nixpkgs.legacyPackages.x86_64-linux;
            };
          in
          [

          nur.nixosModules.nur 
          {
            nixpkgs.overlays = [ nur.overlay ];
          }
          ./machines/potato/configuration.nix


        #/home-manager
        home-manager.nixosModules.home-manager {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "hm-bak";
            users = {
              g = import ./machines/potato/home-manager-g.nix;
            };
            extraSpecialArgs = {
              inherit inputs;
            };
          };
        }
      ];
    };
  };
}