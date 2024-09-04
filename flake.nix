{
  description = "Gman's nix config";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    nixpkgs-master = {
      url = "github:nixos/nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      inherit (self) outputs;
      stateVersion = "24.05";
      lib = nixpkgs.lib;
      myLib = import ./lib/helpers.nix { inherit self inputs outputs lib stateVersion; };
      inherit (myLib) mkHost forAllSystems mapfiles;
    in
    {
      inherit myLib;
      overlays = import ./overlays.nix { inherit inputs; };

      nixosConfigurations = {
        tater = mkHost { hostname = "tater"; users = "g"; desktop = "i3"; };
      };
    };
}
