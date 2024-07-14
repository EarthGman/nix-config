{ inputs, outputs, stateVersion, ... }: {

  # Helper function for generating home-manager configs
  mkHome =
    { hostname
    , username
    , desktop ? null
    , shell ? "zsh"
    , terminal ? "kitty"
    , editor ? "code"
    , wallpaper ? "default.png" # default wallpaper required because stylix will complain if one is not set
    , color-scheme ? null
    , browser ? "firefox"
    , browser-theme ? null
    , search-engine ? "DuckDuckGo"
    , git-username ? "EarthGman"
    , git-email ? "EarthGman@protonmail.com"
    , platform ? "x86_64-linux"
    }: inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages.${platform};
      extraSpecialArgs = {
        inherit inputs outputs hostname username desktop shell terminal editor wallpaper color-scheme browser browser-theme search-engine git-username git-email platform stateVersion;
      };
      modules = [ ../home.nix ];
    };

  mkHost =
    { hostname
    , cpu ? null
    , users ? null
    , git-username ? "EarthGman"
    , git-email ? "EarthGman@protonmail.com"
    , desktop ? null
    , displayManager ? "sddm"
    , platform ? "x86_64-linux"
    , timezone ? "America/Chicago"
    , gpu ? null
    , displayManagerTheme ? null
    }: inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs outputs cpu git-username git-email desktop displayManager displayManagerTheme hostname platform gpu users timezone stateVersion;
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
