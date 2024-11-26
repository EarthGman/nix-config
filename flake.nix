{
  description = "Gman's nix config";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    nixpkgs-master = {
      url = "github:nixos/nixpkgs";
    };

    nixpkgs-stable = {
      url = "github:nixos/nixpkgs/nixos-24.05";
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

    fonts = {
      url = "https://raw.githubusercontent.com/EarthGman/personal-cache/master/fonts.json";
      flake = false;
    };

    binaries = {
      url = "https://raw.githubusercontent.com/EarthGman/personal-cache/master/binaries.json";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
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
        import ./pkgs { inherit pkgs inputs; }
      );

      nixosConfigurations = {
        # Earth's desktops
        cypher = mkHost { hostName = "cypher"; cpu = "amd"; gpu = "amd"; users = "g"; desktop = "i3"; displayManager = "sddm"; };
        garth = mkHost { hostName = "garth"; cpu = "intel"; gpu = "intel-igpu"; users = "g"; desktop = "hyprland,i3"; displayManager = "sddm"; };
        tater = mkHost { hostName = "tater"; cpu = "intel"; gpu = "intel-igpu"; users = "g"; desktop = "hyprland,i3"; displayManager = "sddm"; };
        nixos = mkHost { hostName = "nixos"; vm = true; users = "test"; desktop = "i3"; displayManager = "sddm"; };

        # Thunder's desktops
        somnus = mkHost { hostName = "somnus"; cpu = "amd"; gpu = "amd"; users = "bean"; desktop = "hyprland,i3"; displayManager = "sddm"; };
        pioneer = mkHost { hostName = "pioneer"; cpu = "intel"; gpu = "intel-igpu"; users = "bean"; desktop = "i3"; displayManager = "sddm"; };

        # Iron's desktops
        petrichor = mkHost { hostName = "petrichor"; cpu = "amd"; gpu = "amd"; users = "iron"; desktop = "gnome"; displayManager = "sddm"; };

        # pumpkin's desktops
        thePumpkinPatch = mkHost { hostName = "thePumpkinPatch"; cpu = "amd"; gpu = "nvidia"; users = "pumpkinking"; desktop = "gnome"; displayManager = "sddm"; };

        # servers
        mc112 = mkHost { hostName = "mc112"; server = true; vm = true; }; # main world
        mc-blueprints = mkHost { hostName = "mc-blueprints"; server = true; vm = true; }; # creative blueprints server
        mc121 = mkHost { hostName = "mc121"; server = true; vm = true; }; # private 1.21 server for friends

        iso-headless-x86_64 = mkHost { hostName = "iso-headless"; platform = "x86_64-linux"; };
      };
    };
}
