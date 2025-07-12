{
  description = "Gman's nix config";

  outputs = { self, nixpkgs, home-manager, nix-library, ... } @ inputs:
    let
      inherit (self) outputs;
      helpers = import ./lib/helpers.nix { inherit inputs outputs; };
      myLib = helpers // nix-library.lib;
      lib = nixpkgs.lib.extend
        (final: prev: myLib // home-manager.lib);
    in
    {
      inherit lib;
      overlays = import ./overlays.nix { inherit inputs nixpkgs; };

      nixosModules = import ./modules/nixos { inherit inputs outputs lib; };
      homeModules = import ./modules/home-manager { inherit inputs outputs lib; };

      nixosConfigurations = import ./hosts { inherit self inputs outputs lib; };
      homeConfigurations = import ./home { inherit self lib; };

      packages."x86_64-linux" =
        let
          keys = import ./keys.nix;
        in
        {
          mc112 = lib.mkLXC {
            template = "minecraft";
            extraConfig = ./hosts/mc112;
            personal = true;
            extraSpecialArgs = { inherit keys; };
          };

          mc112-blueprints = lib.mkLXC {
            template = "minecraft";
            extraConfig = ./hosts/mc-blueprints;
            personal = true;
            extraSpecialArgs = { inherit keys; };
          };

          docker-env = lib.mkLXC {
            template = "docker-env";
            personal = true;
            extraSpecialArgs = { inherit keys; };
          };
        };
    };

  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1.0.tar.gz";

    nixos-generators = {
      url = "https://flakehub.com/f/nix-community/nixos-generators/*";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    determinate = {
      url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    swww = {
      url = "github:LGFae/swww";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ghostty = {
      url = "github:ghostty-org/ghostty";
    };

    prismlauncher = {
      url = "github:PrismLauncher/PrismLauncher";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "https://flakehub.com/f/nix-community/stylix/*";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    srvos = {
      url = "github:nix-community/srvos";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    jovian-nixos = {
      url = "github:Jovian-Experiments/Jovian-NixOS";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware = {
      url = "https://flakehub.com/f/NixOS/nixos-hardware/*.tar.gz";
    };

    nix-gaming = {
      url = "github:fufexan/nix-gaming";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/nur";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-library = {
      url = "github:EarthGman/nix-library";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "https://flakehub.com/f/nix-community/home-manager/0.1.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vim-config = {
      url = "github:EarthGman/vim-config";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nix-library.follows = "nix-library";
    };

    disko = {
      url = "https://flakehub.com/f/nix-community/disko/*";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "https://flakehub.com/f/Mic92/sops-nix/*";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wallpapers = {
      url = "https://raw.githubusercontent.com/EarthGman/assets/master/wallpapers.json";
      flake = false;
    };

    icons = {
      url = "https://raw.githubusercontent.com/EarthGman/assets/master/icons.json";
      flake = false;
    };

    binaries = {
      url = "https://raw.githubusercontent.com/EarthGman/assets/master/binaries.json";
      flake = false;
    };
  };
}
