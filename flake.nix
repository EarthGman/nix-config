{

  description = "Gman's nix config";

  inputs = {
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
  };

  outputs = inputs @ { self, nixpkgs, nixpkgs-master, home-manager, nur, ... }:
    let
      flake-inputs = inputs;
      nur-modules = import nur rec {
        nurpkgs = nixpkgs.legacyPackages.x86_64-linux;
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
      };
      pkgs-master = nixpkgs-master.legacyPackages.x86_64-linux;
    in
    {
      nixosConfigurations = {
        # tater
        tater = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit flake-inputs;
          };
          modules =
            [

              nur.nixosModules.nur
              nur-modules.repos.LuisChDev.modules.nordvpn
              {
                nixpkgs.overlays = [ nur.overlay ];
              }
              ./machines/tater/configuration.nix


              # /home-manager
              home-manager.nixosModules.home-manager
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  backupFileExtension = "hm-bak";
                  users = {
                    g = import ./machines/tater/home-manager-g.nix;
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
          specialArgs = {
            inherit flake-inputs;
          };
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
          specialArgs = {
            inherit flake-inputs;
          };
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
