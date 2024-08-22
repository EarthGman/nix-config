{
  description = "Gman's nix config";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-24.05";
    };

    nixpkgs-unstable = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    nixpkgs-master = {
      url = "github:NixOS/nixpkgs";
    };

    # nixpkgs has removed linux kernel 6.9
    nixpkgs_2024-08-14 = {
      url = "github:NixOS/nixpkgs/0cb2fd7c59fed0cd82ef858cbcbdb552b";
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

    stylix = {
      url = "github:danth/stylix";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      inherit (self) outputs;
      stateVersion = "24.05";
      mylib = import ./lib { inherit self inputs outputs stateVersion; };
      inherit (mylib) mkHost mkHome forAllSystems mapfiles;
    in
    {
      overlays = import ./overlays { inherit inputs outputs mylib; };
      wallpapers = mapfiles ./wallpapers;
      icons = mapfiles ./icons;
      nixosConfigurations = {
        # Earth's PCs
        # gaming desktop
        cypher = mkHost { hostname = "cypher"; cpu = "amd"; gpu = "amd"; users = "g"; desktop = "i3"; displayManager = "sddm"; };
        # work laptop
        garth = mkHost { hostname = "garth"; cpu = "intel"; users = "g"; desktop = "i3"; displayManager = "sddm"; };
        # old potato hp laptop
        tater = mkHost { hostname = "tater"; cpu = "intel"; users = "g"; desktop = "gnome"; displayManager = "sddm"; };
        # nixos testing vm
        nixos = mkHost { hostname = "nixos"; cpu = "amd"; users = "test"; desktop = "gnome,i3"; displayManager = "sddm"; };

        # Thunder's PCs
        # gaming desktop
        somnus = mkHost { hostname = "somnus"; cpu = "amd"; gpu = "amd"; users = "bean"; desktop = "gnome,i3"; displayManager = "sddm"; };
        # old dinosaur
        pioneer = mkHost { hostname = "pioneer"; cpu = "intel"; users = "bean"; desktop = "gnome,i3"; displayManager = "sddm"; };

        # Iron's PCs
        petrichor = mkHost { hostname = "petrichor"; cpu = "amd"; gpu = "amd"; users = "iron"; desktop = "gnome"; displayManager = "sddm"; };

        # Pumpkin's PCs
        thePumpkinPatch = mkHost { hostname = "thePumpkinPatch"; cpu = "amd"; gpu = "nvidia"; users = "pumpkinking"; desktop = "gnome"; displayManager = "sddm"; };

        # servers
        mc112 = mkHost { hostname = "server-mc112"; users = "g"; };
        mc121 = mkHost { hostname = "server-mc121"; users = "g"; };
        mc-blueprints = mkHost { hostname = "server-mc-blueprints"; users = "g"; };

        # isos
        iso-x86_64 = mkHost { hostname = "iso-installer"; };
        # broken
        # iso-i686 = mkHost { hostname = "iso-installer"; platform = "i686-linux"; };
      };

      homeConfigurations = {
        "g@cypher" = mkHome { hostname = "cypher"; username = "g"; desktop = "i3"; };
        "g@garth" = mkHome { hostname = "garth"; username = "g"; desktop = "i3"; };
        "g@tater" = mkHome { hostname = "tater"; username = "g"; desktop = "gnome"; };
        "test@nixos" = mkHome { hostname = "nixos"; username = "test"; desktop = "gnome,i3"; };

        "bean@somnus" = mkHome { hostname = "somnus"; username = "bean"; desktop = "gnome,i3"; git-username = "Thunderbean290"; git-email = "156272091+Thunderbean290@users.noreply.github.com"; };
        "bean@pioneer" = mkHome { hostname = "pioneer"; username = "bean"; desktop = "gnome,i3"; git-username = "Thunderbean290"; git-email = "156272091+Thunderbean290@users.noreply.github.com"; };

        "iron@petrichor" = mkHome { hostname = "petrichor"; username = "iron"; desktop = "gnome"; git-username = "IronCutlass"; git-email = "nogreenink@gmail.com"; };

        "pumpkinking@thePumpkinPatch" = mkHome { hostname = "thePumpkinPatch"; username = "pumpkinking"; desktop = "gnome"; git-username = "PumpkinKing432"; git-email = "trombonekidd17@gmail.com"; };
      };

      packages = forAllSystems (system:
        let
          pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
        in
        import ./pkgs { inherit pkgs mylib; }
      );
    };
}
