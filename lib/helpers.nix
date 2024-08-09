{ self, inputs, outputs, stateVersion, ... }: rec {

  # Helper function for generating home-manager configs
  mkHome =
    { hostname
    , username
    , desktop ? null
    , editor ? "code"
    , git-username ? "EarthGman"
    , git-email ? "EarthGman@protonmail.com"
    , platform ? "x86_64-linux"
    }: inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages.${platform};
      extraSpecialArgs = {
        inherit self inputs outputs hostname username desktop editor git-username git-email platform stateVersion;
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
    , platform ? "x86_64-linux"
    }: inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit self inputs outputs hostname cpu gpu users desktop displayManager platform stateVersion;
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

  # generates attribute set with keyname of base filename with .(extension) removed. Value is store path
  splitFilename = file:
    let
      parts = builtins.match "(.*)\\.(.*)" (builtins.baseNameOf file);
    in
    if parts == null then
      { name = builtins.baseNameOf file; ext = ""; }
    else
      { name = builtins.elemAt parts 0; ext = builtins.elemAt parts 1; };
  mapfiles = dir:
    let
      files = builtins.attrNames (builtins.readDir dir);
    in
    builtins.listToAttrs (builtins.map (file: { name = (splitFilename file).name; value = "${dir}/${file}"; }) files);
}
