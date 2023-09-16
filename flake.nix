{
  description = "Gman's Nix Config";

  inputs = {
    nur.url = "github:nix-community/NUR";
    # Shameless plug: looking for a way to nixify your themes and make
    # everything match nicely? Try nix-colors!
    # nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    nur,
    ... 
  }: 
  let
    inherit (self) outputs;
    forAllSystems = nixpkgs.lib.genAttrs [ "aarch64-linux" "x86_64-linux" ];
  in
    rec {
      # Devshell for bootstrapping
      # Acessible through 'nix develop' or 'nix-shell' (legacy)
      devShells = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in {
          default = pkgs.mkShell {
          # Enable experimental features without having to specify the argument
          NIX_CONFIG = "experimental-features = nix-command flakes";
          nativeBuildInputs = with pkgs; [ nix home-manager git ];
        };
      }
    );

      # Your custom packages and modifications, exported as overlays
      overlays = import ./overlays { inherit inputs; };
      # Reusable nixos modules you might want to export
      # These are usually stuff you would upstream into nixpkgs
      nixosModules = import ./modules/nixos;
      # Reusable home-manager modules you might want to export
      # These are usually stuff you would upstream into home-manager
      homeManagerModules = import ./modules/home-manager;

      # NixOS configuration entrypoint
      # Available through 'nixos-rebuild --flake .#your-hostname'
      nixosConfigurations = {
        "nixvm" = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = let
            nur-modules = import nur rec {
              nurpkgs = nixpkgs.legacyPackages.x86_64-linux;
              pkgs = nixpkgs.legacyPackages.x86_64-linux;
            };
          in [
              ./machines/nixvm/configuration.nix
            # ...the rest of your modules
            nur.nixosModules.nur
            nur-modules.repos.LuisChDev.modules.nordvpn
          ];
        };
        "pav" = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [
            ./machines/pav/configuration.nix
          ];
        };
      };

      #darwinConfigurations = { }

      # Standalone home-manager configuration entrypoint
      # Available through 'home-manager --flake .#your-username@your-hostname'
      # homeConfigurations = {
      #   "g@nixos" = home-manager.lib.homeManagerConfiguration {
      #     pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
      #     extraSpecialArgs = { inherit inputs outputs; };
      #     modules = [
      #       # > Our main home-manager configuration file <
      #       ./home-manager/home.nix
      #     ];
      #   };
      # };
    };
}
