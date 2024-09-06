{ self, inputs, outputs, lib, stateVersion, ... }: rec {

  mkHost =
    { hostName
    , cpu ? null
    , gpu ? null
    , username ? null
    , desktop ? null
    , vm ? "no"
    , displayManager ? null
    , platform ? "x86_64-linux"
    }:
    let
      myLib = outputs.myLib;
    in
    lib.nixosSystem {
      specialArgs = {
        inherit self myLib platform inputs outputs hostName cpu gpu username desktop displayManager vm stateVersion;
      };
      modules =
        let
          isISO = (builtins.substring 0 4 hostName == "iso-");
          isVM = (vm == "yes");
          cd-dvd =
            if (desktop == null) then
              inputs.nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
            else
              inputs.nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-graphical-calamares.nix";
          qemu-guest = inputs.nixpkgs + "nixos/modules/profiles/qemu-guest.nix";
          desktop-setup = self + /templates/nixos/desktop.nix;
          iso-setup = self + /templates/nixos/iso.nix;
        in
        [ ../hosts ]
        ++ lib.optionals (isISO) [ cd-dvd iso-setup ]
        ++ lib.optionals (isVM) [ qemu-guest ]
        ++ lib.optionals (desktop != null) [ desktop-setup ];
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

  # takes a string with elements split by a comma such as "alice,bob" and will create list [ alice bob ]
  splitToList = string: builtins.filter builtins.isString (builtins.split "," string);
}
