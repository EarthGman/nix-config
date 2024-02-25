{
  description = "Gman's nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-gaming = {
      url = "github:fufexan/nix-gaming";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib // home-manager.lib;
      systems = [ "x86_64-linux" ];

      forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});
      pkgsFor = lib.genAttrs systems (system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        });
    in
    {
      inherit lib;

      packages = forEachSystem (pkgs: import ./pkgs { inherit pkgs; });
      overlays = import ./overlays { inherit inputs outputs; };

      nixosConfigurations = {
        # old laptop
        tater = lib.nixosSystem {
          modules = [ ./machines/tater ];
          specialArgs = { inherit inputs outputs; };
        };
        # gaming desktop
        cypher = lib.nixosSystem {
          modules = [ ./machines/cypher ];
          specialArgs = { inherit inputs outputs; };
        };
        # main laptop
        garth = lib.nixosSystem {
          modules = [ ./machines/garth ];
          specialArgs = { inherit inputs outputs; };
        };
      };

      homeConfigurations = {
        "g@cypher" = lib.homeManagerConfiguration {
          modules = [ ./machines/cypher/home-g.nix ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
        };
        "g@tater" = lib.homeManagerConfiguration {
          modules = [ ./machines/tater/home-g.nix ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
        };
        "g@garth" = lib.homeManagerConfiguration {
          modules = [ ./machines/garth/home-g.nix ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
        };
      };
    };
}
