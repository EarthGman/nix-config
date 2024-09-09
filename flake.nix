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

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wallpapers = {
      url = "https://raw.githubusercontent.com/EarthGman/personal-cache/master/wallpapers.json";
      flake = false;
    };

    icons = {
      url = "https://raw.githubusercontent.com/EarthGman/personal-cache/master/icons.json";
      flake = false;
    };

    binaries = {
      url = "https://raw.githubusercontent.com/EarthGman/personal-cache/master/binaries.json";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, wallpapers, ... }@inputs:
    let
      inherit (self) outputs;
      stateVersion = "24.05";
      lib = nixpkgs.lib;
      myLib = import ./lib/helpers.nix { inherit self inputs outputs lib stateVersion; };
      inherit (myLib) mkHost forAllSystems;
    in
    {
      inherit myLib;
      overlays = import ./overlays.nix { inherit inputs myLib; };
      packages = forAllSystems (system:
        let
          pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
        in
        import ./pkgs { inherit pkgs myLib; }
      );

      nixosConfigurations = {
        cypher = mkHost { hostName = "cypher"; cpu = "amd"; gpu = "amd"; users = "g"; desktop = "i3"; displayManager = "sddm"; };
        tater = mkHost { hostName = "tater"; cpu = "intel"; gpu = "intel-igpu"; users = "g"; desktop = "i3"; displayManager = "sddm"; };
        garth = mkHost { hostName = "garth"; cpu = "intel"; gpu = "intel-igpu"; users = "g"; desktop = "i3"; displayManager = "sddm"; };
        nixos = mkHost { hostName = "nixos"; vm = "yes"; users = "test,test2"; desktop = "i3"; displayManager = "sddm"; };

        server-mc112 = mkHost { hostName = "server-mc112"; vm = "yes"; };
        server-mc-blueprints = mkHost { hostName = "server-mc-blueprints"; vm = "yes"; };
        server-mc121 = mkHost { hostName = "server-mc121"; vm = "yes"; };

        iso-headless-x86_64 = mkHost { hostName = "iso-headless"; platform = "x86_64-linux"; };
      };
    };
}
