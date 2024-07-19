{ inputs, outputs, stateVersion, ... }: {

  # Helper function for generating home-manager configs
  mkHome =
    { hostname
    , username
    , desktop ? null
    , editor ? "code"
    , wallpaper ? "default.png" # default wallpaper required because stylix will complain if one is not set
    , color-scheme ? null
    , git-username ? "EarthGman"
    , git-email ? "EarthGman@protonmail.com"
    , platform ? "x86_64-linux"
    }: inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages.${platform};
      extraSpecialArgs = {
        inherit inputs outputs hostname username desktop editor wallpaper color-scheme git-username git-email platform stateVersion;
      };
      modules = [ ../home.nix ];
    };

  mkHost =
    { hostname
    , cpu ? null
    , gpu ? null
    , users ? null
    , desktop ? null
    , displayManager ? "sddm"
    , displayManagerTheme ? null
    , platform ? "x86_64-linux"
    , grub-theme ? "nixos"
    , git-username ? "EarthGman"
    , git-email ? "EarthGman@protonmail.com"
    }: inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs outputs hostname cpu gpu users desktop displayManager displayManagerTheme grub-theme git-username git-email platform stateVersion;
      };
      # If the hostname starts with "iso-", generate an ISO image
      modules =
        let
          isISO = (builtins.substring 0 4 hostname == "iso-");
          cd-dvd =
            if (desktop == null) then
              inputs.nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
            else
              inputs.nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-graphical-calamares.nix";
        in
        [
          ../hosts
        ] ++ (inputs.nixpkgs.lib.optionals (isISO) [ cd-dvd ]);
    };

  forAllSystems = inputs.nixpkgs.lib.genAttrs [
    "aarch64-linux"
    "i686-linux"
    "x86_64-linux"
    "aarch64-darwin"
    "x86_64-darwin"
  ];
}
