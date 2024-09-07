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

    nur = {
      url = "github:nix-community/nur";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
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
      wallpapers = mapfiles ./wallpapers;
      icons = mapfiles ./icons;
      overlays = import ./overlays.nix {
        inherit inputs myLib;
      };
      packages = forAllSystems (system:
        let
          pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
        in
        import ./pkgs { inherit pkgs myLib; }
      );

      nixosConfigurations = {
        cypher = mkHost { hostName = "cypher"; cpu = "amd"; gpu = "amd"; username = "g"; desktop = "i3"; displayManager = "sddm"; };
        tater = mkHost { hostName = "tater"; cpu = "intel"; gpu = "intel-igpu"; username = "g"; desktop = "i3"; displayManager = "sddm"; };
        garth = mkHost { hostName = "garth"; cpu = "intel"; gpu = "intel-igpu"; username = "g"; desktop = "i3"; displayManager = "sddm"; };
        nixos = mkHost { hostName = "nixos"; username = "test"; desktop = "gnome"; displayManager = "sddm"; vm = "yes"; };

        iso-headless-x86_64 = mkHost { hostName = "iso-headless"; platform = "x86_64-linux"; };
      };
    };
}
