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

    vim-config = {
      url = "github:EarthGman/vim-config";
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
      lib = nixpkgs.lib.extend
        (final: prev: import ./lib { inherit self inputs outputs; });
      inherit (lib) mkHost forAllSystems;
    in
    {
      inherit lib;
      overlays = import ./overlays.nix { inherit inputs; };
      packages = forAllSystems (system:
        let
          pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
        in
        import ./pkgs { inherit pkgs inputs; }
      );

      nixosConfigurations = {
        # Earth's desktops
        cypher = mkHost { hostName = "cypher"; cpu = "amd"; gpu = "amd"; users = [ "g" ]; desktop = "i3"; stateVersion = "24.05"; };
        garth = mkHost { hostName = "garth"; cpu = "intel"; gpu = "intel-igpu"; users = [ "g" ]; desktop = "hyprland,i3"; stateVersion = "24.05"; };
        tater = mkHost { hostName = "tater"; cpu = "intel"; gpu = "intel-igpu"; users = [ "g" ]; desktop = "hyprland,i3"; stateVersion = "24.11"; };
        nixos = mkHost { hostName = "nixos"; vm = true; users = [ "test" ]; desktop = "hyprland"; stateVersion = "24.11"; };
        nixos-arm = mkHost { hostName = "nixos-arm"; vm = true; users = [ "test" "k" ]; desktop = "hyprland"; platform = "aarch64-linux"; stateVersion = "24.11"; };

        # Thunder's desktops
        somnus = mkHost { hostName = "somnus"; cpu = "amd"; gpu = "amd"; users = [ "bean" ]; desktop = "hyprland,i3"; stateVersion = "24.05"; };
        pioneer = mkHost { hostName = "pioneer"; cpu = "intel"; gpu = "intel-igpu"; users = [ "bean" ]; desktop = "i3"; stateVersion = "24.11"; };

        # Iron's desktops
        petrichor = mkHost { hostName = "petrichor"; cpu = "amd"; gpu = "amd"; users = [ "iron" ]; desktop = "gnome"; stateVersion = "24.05"; };

        # pumpkin's desktops
        thePumpkinPatch = mkHost { hostName = "thePumpkinPatch"; cpu = "amd"; gpu = "nvidia"; users = [ "pumpkinking" ]; desktop = "gnome"; stateVersion = "24.05"; };

        # servers
        mc112 = mkHost { hostName = "mc112"; server = true; vm = true; stateVersion = "24.11"; }; # main world
        mc-blueprints = mkHost { hostName = "mc-blueprints"; server = true; vm = true; stateVersion = "24.11"; }; # creative blueprints server
        mc121 = mkHost { hostName = "mc121"; server = true; vm = true; stateVersion = "24.11"; }; # private 1.21 server for friends

        headless-x86_64-iso = mkHost { hostName = "Nixos Installer"; iso = true; platform = "x86_64-linux"; };
      };
    };
}
