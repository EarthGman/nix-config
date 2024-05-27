{ inputs, outputs, stateVersion, ... }: {

  # Helper function for generating home-manager configs
  mkHome = { hostname, username, git-username, git-email, desktop ? null, platform ? "x86_64-linux", search-engine ? "DuckDuckGo" }: inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = inputs.nixpkgs.legacyPackages.${platform};
    extraSpecialArgs = {
      inherit inputs outputs desktop hostname platform username git-username git-email search-engine stateVersion;
    };
    modules = [ ../machines/${hostname}/home-${username}.nix ];
  };

  mkHost = { hostname, username, desktop ? null, displayManager ? "sddm", platform ? "x86_64-linux", timezone ? "America/Chicago", gpu ? null }: inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {
      inherit inputs outputs desktop displayManager hostname platform gpu username timezone stateVersion;
    };
    # If the hostname starts with "iso-", generate an ISO image
    modules =
      let
        isISO = if (builtins.substring 0 4 hostname == "iso-") then true else false;
        cd-dvd = if (desktop == null) then inputs.nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix" else inputs.nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-graphical-calamares.nix";
      in
      [
        ../machines/${hostname}
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
