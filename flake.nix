{

  description = "Gman's nix config";

  inputs = {
    nur.url = "github:nix-community/NUR";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
  };

  outputs = inputs @ { self, nixpkgs, nixpkgs-master, home-manager, nur, ... }:
    let
      nur-modules = import nur rec {
        nurpkgs = nixpkgs.legacyPackages.x86_64-linux;
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
      };
      pkgs-master = nixpkgs-master.legacyPackages.x86_64-linux;
    in
    {
      nixosConfigurations = {
        # potato
        potato = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules =
            [

              nur.nixosModules.nur
              {
                nixpkgs.overlays = [ nur.overlay ];
              }
              ./machines/potato/configuration.nix


              # /home-manager
              home-manager.nixosModules.home-manager
              {
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

        # main
        cypher = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules =
            [

              nur.nixosModules.nur
              nur-modules.repos.LuisChDev.modules.nordvpn
              {
                nixpkgs.overlays = [ nur.overlay ];
              }

              ./machines/cypher/configuration.nix


              # /home-manager
              home-manager.nixosModules.home-manager
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  backupFileExtension = "hm-bak";
                  users = {
                    g = import ./machines/cypher/home-manager-g.nix;
                  };
                  extraSpecialArgs = {
                    inherit inputs pkgs-master;
                  };
                };
              }
            ];
        };

        #laptop
        garth = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules =
            [

              nur.nixosModules.nur
              nur-modules.repos.LuisChDev.modules.nordvpn
              {
                nixpkgs.overlays = [ nur.overlay ];
              }

              ./machines/garth/configuration.nix


              # /home-manager
              home-manager.nixosModules.home-manager
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  backupFileExtension = "hm-bak";
                  users = {
                    g = import ./machines/garth/home-manager-g.nix;
                  };
                  extraSpecialArgs = {
                    inherit inputs pkgs-master;
                  };
                };
              }
            ];
        };
      };
    };
}
