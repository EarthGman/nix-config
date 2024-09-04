{ self, inputs, outputs, lib, stateVersion, ... }: rec {

  mkHost =
    { hostname
    , cpu ? null
    , gpu ? null
    , users ? null
    , desktop ? null
    , displayManager ? "sddm"
    , platform ? "x86_64-linux"
    }: lib.nixosSystem {
      specialArgs = {
        inherit self platform inputs outputs hostname cpu gpu users desktop displayManager stateVersion;
      };
      modules =
        let
          isISO = (builtins.substring 0 4 hostname == "iso-");
          cd-dvd =
            if (desktop == null) then
              inputs.nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
            else
              inputs.nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-graphical-calamares.nix";
        in
        [ ../configuration.nix ] ++ lib.optionals (isISO) [ cd-dvd ];
    };

  forAllSystems = lib.genAttrs [
    "aarch64-linux"
    "aarch64-darwin"
    "i686-linux"
    "x86_64-linux"
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
