{
  description = "Gman's nix config";

  inputs = {
    nixpkgs-unstable = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-24.05";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/nur";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
    };

    xremap = {
      url = "github:xremap/nix-flake";
    };

    stylix = {
      url = "github:danth/stylix";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
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
        # Earth's PCs
        # gaming desktop
        cypher = lib.mkHost { hostname = "cypher"; users = "g"; desktop = "gnome,hyprland"; displayManager = "sddm"; displayManagerTheme = "utterly-sweet"; gpu = "amd"; };
        # work laptop
        garth = lib.mkHost { hostname = "garth"; users = "g"; desktop = "gnome"; displayManager = "sddm"; displayManagerTheme = "utterly-sweet"; };
        # old potato hp laptop
        tater = lib.mkHost { hostname = "tater"; users = "g"; desktop = "gnome"; displayManager = "sddm"; displayManagerTheme = "utterly-sweet"; };
        # nixos testing vm
        nixos = lib.mkHost { hostname = "nixos"; users = "g,test"; desktop = "gnome"; displayManager = "sddm"; displayManagerTheme = "hallow-knight"; };

        # Thunder's PCs
        # gaming desktop
        somnus = lib.mkHost { hostname = "somnus"; users = "bean"; desktop = "gnome,hyprland"; displayManager = "sddm"; displayManagerTheme = "utterly-sweet"; gpu = "amd"; };

        # servers
        testvm1 = lib.mkHost { hostname = "prox-template"; users = "g"; };

        # isos
        iso-x86_64 = lib.mkHost { hostname = "iso-headless"; };
        iso-i686 = lib.mkHost { hostname = "iso-headless"; platform = "i686-linux"; };
      };

      homeConfigurations = {
        "g@cypher" = lib.mkHome { hostname = "cypher"; username = "g"; desktop = "gnome,hyprland"; wallpaper = "fiery-dragon.jpg"; stylix-theme = "home-depot"; editor = "code"; git-username = "EarthGman"; git-email = "EarthGman@protonmail.com"; };
        "g@garth" = lib.mkHome { hostname = "garth"; username = "g"; desktop = "gnome"; wallpaper = "fiery-dragon.jpg"; stylix-theme = "home-depot"; editor = "code"; git-username = "EarthGman"; git-email = "EarthGman@protonmail.com"; };
        "g@tater" = lib.mkHome { hostname = "tater"; username = "g"; desktop = "gnome"; editor = "code"; git-username = "EarthGman"; git-email = "EarthGman@protonmail.com"; };
        "g@nixos" = lib.mkHome { hostname = "nixos"; username = "g"; desktop = "gnome"; editor = "code"; git-username = "EarthGman"; git-email = "EarthGman@protonmail.com"; };
        "test@nixos" = lib.mkHome { hostname = "nixos"; username = "test"; desktop = "gnome"; editor = "code"; git-username = "EarthGman"; git-email = "EarthGman@protonmail.com"; };

        "bean@somnus" = lib.mkHome { hostname = "somnus"; username = "bean"; desktop = "gnome,hyprland"; wallpaper = "crystal-tower.jpg"; stylix-theme = "nocturne"; editor = "code"; git-username = "Thunderbean290"; git-email = "156272091+Thunderbean290@users.noreply.github.com"; };
      };
    };
}
