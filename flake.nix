{
  description = "Gman's nix config";

  inputs = {
    nixpkgs-unstable = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-24.05";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/nur";
    };

    xremap = {
      url = "github:xremap/nix-flake";
    };

    stylix = {
      url = "github:danth/stylix";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      inherit (self) outputs;
      stateVersion = "24.05";
      lib = import ./lib { inherit inputs outputs stateVersion; };
    in
    {
      overlays = import ./overlays { inherit inputs outputs; };
      nixosConfigurations = {
        # gaming desktop
        cypher = lib.mkHost { hostname = "cypher"; username = "g"; desktop = "gnome,cinnamon"; displayManager = "sddm"; displayManagerTheme = "utterly-sweet"; gpu = "amd"; };
        # flake rebuild vm
        nixos = lib.mkHost { hostname = "nixos"; username = "g"; desktop = "gnome"; displayManager = "sddm"; displayManagerTheme = "hallow-knight"; };
      };

      homeConfigurations = {
        "g@cypher" = lib.mkHome { hostname = "cypher"; username = "g"; desktop = "gnome"; editor = "code"; git-username = "EarthGman"; git-email = "EarthGman@protonmail.com"; };
        "g@nixos" = lib.mkHome { hostname = "nixos"; username = "g"; desktop = "gnome"; editor = "code"; git-username = "EarthGman"; git-email = "EarthGman@protonmail.com"; };
      };
    };
}
