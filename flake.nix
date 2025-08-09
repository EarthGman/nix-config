{
  description = "Gman's nix config";

  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1.0.tar.gz";

    assets = {
      url = "github:earthgman/assets";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nix-library.follows = "nix-library";
    };

    determinate = {
      url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "https://flakehub.com/f/nix-community/disko/*";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "https://flakehub.com/f/nix-community/home-manager/0.1.0.tar.gz";
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

    sops-nix = {
      url = "https://flakehub.com/f/Mic92/sops-nix/*";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "https://flakehub.com/f/nix-community/stylix/*";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nur.follows = "nur";
    };

    vim-config = {
      url = "github:EarthGman/vim-config";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nix-library.follows = "nix-library";
    };
  };

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

      nixosModules = import ./modules/nixos { inherit inputs lib; };
      homeModules = import ./modules/home-manager { inherit inputs lib; };

      nixosConfigurations = import ./hosts { inherit lib self inputs; };
      homeConfigurations = import ./home { inherit lib self inputs; };

      overlays = import ./overlays.nix { inherit inputs; };
    };
}
