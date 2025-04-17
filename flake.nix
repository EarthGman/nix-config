{
  description = "Gman's nix config";

  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1.0.tar.gz";
    nixpkgs-stable.url = "https://flakehub.com/f/NixOS/nixpkgs/*";
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
      url = "https://flakehub.com/f/nix-community/home-manager/0.1.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vim-config = {
      url = "github:EarthGman/vim-config";
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
    in
    {
      inherit lib;
      keys = import ./keys.nix;
      overlays = import ./overlays.nix { inherit inputs; };
      packages = nix-library.packages;

      nixosModules = import ./modules/nixos { inherit outputs lib; };
      homeManagerModules = import ./modules/home-manager { inherit outputs lib; };
      sharedModules = import ./modules/shared { inherit lib; };

      nixosProfiles = {
        default = import ./profiles/nixos;
        desktop = import ./profiles/nixos/desktop.nix;
        server = import ./profiles/nixos/server;
        iso = import ./profiles/nixos/iso.nix;
        gaming = import ./profiles/nixos/gaming.nix;
        laptop = import ./profiles/nixos/laptop.nix;
        gmans-keymap = import ./profiles/nixos/keyd/gmans-keymap.nix;
        gman-pc = import ./profiles/nixos/gman-pc.nix;
        hacker-mode = import ./profiles/nixos/hacker-mode.nix;
      };

      homeProfiles = {
        default = import ./profiles/home-manager;
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
