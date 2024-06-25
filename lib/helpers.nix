{ inputs, outputs, stateVersion, ... }: {

  # Helper function for generating home-manager configs
  mkHome =
    { hostname
    , username
    , editor ? "code"
    , wallpaper ? "default.png" # default wallpaper required because stylix will complain if one is not set
    , stylix-theme ? null
    , git-username ? null
    , git-email ? null
    , desktop ? null
    , platform ? "x86_64-linux"
    , search-engine ? "DuckDuckGo"
    }: inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages.${platform};
      extraSpecialArgs = {
        inherit inputs outputs desktop wallpaper stylix-theme hostname platform username editor git-username git-email search-engine stateVersion;
      };
      modules = [ ../home.nix ];
    };

  mkHost =
    { hostname
    , users ? null
    , git-username ? null
    , git-email ? null
    , desktop ? null
    , displayManager ? "sddm"
    , platform ? "x86_64-linux"
    , timezone ? "America/Chicago"
    , gpu ? null
    , displayManagerTheme ? null
    }: inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs outputs git-username git-email desktop displayManager displayManagerTheme hostname platform gpu users timezone stateVersion;
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

  # unused as of now
  forAllSystems = inputs.nixpkgs.lib.genAttrs [
    "aarch64-linux"
    "i686-linux"
    "x86_64-linux"
    "aarch64-darwin"
    "x86_64-darwin"
  ];
}
