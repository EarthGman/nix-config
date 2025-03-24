{
  description = "Gman's nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    hyprland.url = "github:hyprwm/Hyprland";
    swww.url = "github:LGFae/swww";
    ghostty.url = "github:ghostty-org/ghostty";
    prismlauncher.url = "github:PrismLauncher/PrismLauncher";
    stylix.url = "github:danth/stylix";
    srvos.url = "github:nix-community/srvos";
    nix-gaming.url = "github:fufexan/nix-gaming";
    nur.url = "github:nix-community/nur";

    nix-library = {
      url = "github:EarthGman/nix-library";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vim-config = {
      url = "github:EarthGman/vim-config";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
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

  outputs = { self, nixpkgs, home-manager, nix-library, ... } @ inputs:
    let
      inherit (self) outputs;
      helpers = import ./lib/helpers.nix { inherit self outputs; };
      myLib = helpers // nix-library.lib;
      lib = nixpkgs.lib.extend # must overlay the lib functions like this or else weird stuff happens for some reason
        (final: prev: myLib // home-manager.lib);
      inherit (lib) autoImport;
    in
    {
      inherit lib;
      keys = import ./keys.nix;
      overlays = import ./overlays.nix { inherit inputs; };
      packages = nix-library.packages;

      nixosModules = {
        imports = autoImport ./modules/nixos;
      };

      nixosProfiles = {
        desktop = import ./profiles/nixos/desktop.nix;
        server = import ./profiles/nixos/server;
        iso = import ./profiles/nixos/iso.nix;
        gaming = import ./profiles/nixos/gaming.nix;
        laptop = import ./profiles/nixos/laptop.nix;
        gmans-keymap = import ./profiles/nixos/keyd/gmans-keymap.nix;
        gman-pc = import ./profiles/nixos/gman-pc.nix;
        hacker-mode = import ./profiles/nixos/hacker-mode.nix;
      };

      homeManagerModules = import ./modules/home-manager { inherit lib; };

      homeProfiles = {
        essentials = import ./profiles/home-manager/essentials.nix;
        desktopThemes = {
          april = import ./profiles/home-manager/desktop-themes/april.nix;
          ashes = import ./profiles/home-manager/desktop-themes/ashes.nix;
          cosmos = import ./profiles/home-manager/desktop-themes/cosmos.nix;
          faraway = import ./profiles/home-manager/desktop-themes/faraway.nix;
          headspace = import ./profiles/home-manager/desktop-themes/headspace.nix;
          determination = import ./profiles/home-manager/desktop-themes/determination.nix;
          inferno = import ./profiles/home-manager/desktop-themes/inferno.nix;
          nightmare = import ./profiles/home-manager/desktop-themes/nightmare.nix;
          vibrant-cool = import ./profiles/home-manager/desktop-themes/vibrant-cool.nix;
          celeste = import ./profiles/home-manager/desktop-themes/celeste.nix;
        };
      };

      nixosConfigurations = import ./hosts { inherit lib; };
      homeConfigurations = import ./home { inherit lib; };
    };
}
