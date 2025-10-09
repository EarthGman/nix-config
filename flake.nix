{
  description = "Gman's nix config";

  outputs =
    {
      self,
      nixpkgs,
      nix-library,
      home-manager,
      ...
    }@inputs:
    let
      myLib =
        (import ./lib {
          inherit inputs;
          outputs = self.outputs;
        })
        // nix-library.lib;
      lib = nixpkgs.lib.extend (final: prev: (myLib // home-manager.lib));
    in
    {
      inherit lib;

      nixosModules = rec {
        gman = import ./modules/nixos { inherit inputs lib; };
        default = gman;
      };

      homeModules = rec {
        gman = import ./modules/home-manager { inherit inputs lib; };
        default = gman;
      };

      nixosConfigurations = import ./hosts { inherit lib inputs; };
      homeConfigurations = import ./home { inherit lib inputs; };

      overlays = import ./overlays.nix { inherit inputs; };
    };

  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1.0.tar.gz";

    determinate = {
      url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "https://flakehub.com/f/nix-community/home-manager/0.1.0.tar.gz";
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

    nix-library = {
      url = "github:EarthGman/nix-library";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/nur";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    prismlauncher = {
      url = "github:PrismLauncher/PrismLauncher";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "https://flakehub.com/f/Mic92/sops-nix/*";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "https://flakehub.com/f/nix-community/stylix/*";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nur.follows = "nur";
    };

    swww = {
      url = "github:LGFae/swww";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vim-config = {
      url = "github:EarthGman/vim-config";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
