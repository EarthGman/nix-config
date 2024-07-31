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
      lib = import ./lib { inherit self inputs outputs stateVersion; };
      inherit (lib) mkHost mkHome forAllSystems;
    in
    {
      overlays = import ./overlays { inherit inputs outputs; };
      nixosConfigurations = {
        # Earth's PCs
        # gaming desktop
        cypher = mkHost { hostname = "cypher"; cpu = "amd"; gpu = "amd"; users = "g"; desktop = "gnome,i3"; displayManager = "sddm"; displayManagerTheme = "april"; };
        # work laptop
        garth = mkHost { hostname = "garth"; cpu = "intel"; users = "g"; desktop = "i3"; displayManager = "sddm"; displayManagerTheme = "inferno"; };
        # old potato hp laptop
        tater = mkHost { hostname = "tater"; cpu = "intel"; users = "g"; desktop = "gnome"; displayManager = "sddm"; displayManagerTheme = "utterly-sweet"; };
        # nixos testing vm
        nixos = mkHost { hostname = "nixos"; cpu = "amd"; users = "test"; desktop = "gnome,i3"; displayManager = "sddm"; displayManagerTheme = "utterly-sweet"; };

        # Thunder's PCs
        # gaming desktop
        somnus = mkHost { hostname = "somnus"; cpu = "amd"; gpu = "amd"; users = "bean"; desktop = "gnome,i3"; displayManager = "sddm"; displayManagerTheme = "reverie"; };
        # old dinosaur
        xj9 = mkHost { hostname = "xj9"; cpu = "amd"; users = "sniffer"; desktop = "gnome"; displayManager = "sddm"; displayManagerTheme = "utterly-sweet"; };

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
        "g@cypher" = mkHome { hostname = "cypher"; username = "g"; desktop = "gnome,i3"; wallpaper = "kaori.jpg"; color-scheme = "april"; };
        "g@garth" = mkHome { hostname = "garth"; username = "g"; desktop = "i3"; wallpaper = "fiery-dragon.jpg"; color-scheme = "inferno"; };
        "g@tater" = mkHome { hostname = "tater"; username = "g"; desktop = "gnome"; };
        "test@nixos" = mkHome { hostname = "nixos"; username = "test"; desktop = "gnome,i3"; color-scheme = "ashes"; wallpaper = "scarlet-tree-dark.png"; };

        "bean@somnus" = mkHome { hostname = "somnus"; username = "bean"; desktop = "gnome,i3"; color-scheme = "headspace"; wallpaper = "the-gang.jpg"; git-username = "Thunderbean290"; git-email = "156272091+Thunderbean290@users.noreply.github.com"; };
        "sniffer@xj9" = mkHome { hostname = "xj9"; username = "sniffer"; desktop = "gnome"; git-username = null; git-email = null; };
      };

      packages = forAllSystems (system:
        let
          pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
        in
        import ./pkgs { inherit pkgs; }
      );
    };
}
