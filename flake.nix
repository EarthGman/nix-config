{
  description = "Gman's nix config";

  outputs =
    {
      self,
      nixpkgs,
      ...
    }@inputs:
    let
      supported-systems = [
        "x86_64-linux"
        "aarch_64-linux"
      ];
      myLib = (
        import ./lib {
          inherit inputs;
          lib = nixpkgs.lib;
          outputs = self.outputs;
        }
      );
      lib = nixpkgs.lib.extend (final: prev: (myLib));
    in
    {
      inherit lib;

      nixosModules = rec {
        gman = import ./modules/nixos { inherit inputs lib; };
        default = gman;
      };

      nixosConfigurations = import ./hosts { inherit lib inputs; };

      packages = lib.genAttrs supported-systems (
        system:
        import ./packages {
          inherit inputs;
          pkgs = nixpkgs.legacyPackages.${system};
        }
      );

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

    prismlauncher = {
      url = "github:PrismLauncher/PrismLauncher";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "https://flakehub.com/f/Mic92/sops-nix/*";
      inputs.nixpkgs.follows = "nixpkgs";
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
