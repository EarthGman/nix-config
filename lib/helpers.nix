{ self, inputs, outputs, lib, stateVersion, ... }: rec {

  mkHost =
    { hostName
    , cpu ? null
    , gpu ? null
    , users ? "" # string of custom defined users sperated by a comma. First element is the power user.
    , desktop ? null
    , vm ? "no"
    , displayManager ? null
    , platform ? "x86_64-linux"
    }:
    let
      myLib = outputs.myLib;
      wallpapers = builtins.fromJSON (builtins.readFile inputs.wallpapers.outPath);
      icons = builtins.fromJSON (builtins.readFile inputs.icons.outPath);
      binaries = builtins.fromJSON (builtins.readFile inputs.binaries.outPath);
    in
    lib.nixosSystem {
      specialArgs = {
        inherit self platform inputs outputs myLib wallpapers icons binaries hostName cpu gpu users desktop displayManager vm stateVersion;
      };
      modules =
        let
          inherit (lib) optionals;
          isISO = (builtins.substring 0 4 hostName == "iso-");
          isVM = (vm == "yes");
          isServer = (builtins.substring 0 7 hostName == "server-");
          cd-dvd =
            if (desktop == null) then
              inputs.nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
            else
              inputs.nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-graphical-calamares.nix";
          qemu-guest = inputs.nixpkgs + "/nixos/modules/profiles/qemu-guest.nix";
          desktop-setup = self + /profiles/nixos/desktop.nix;
          iso-setup = self + /profiles/nixos/iso.nix;
          server-setup = self + /profiles/nixos/server;
        in
        [ ../hosts ]
        ++ optionals (isISO) [ cd-dvd iso-setup ]
        ++ optionals (isVM) [ qemu-guest ]
        ++ optionals (desktop != null) [ desktop-setup ]
        ++ optionals (isServer) [ server-setup ];
    };

  forAllSystems = lib.genAttrs [
    "aarch64-linux"
    "aarch64-darwin"
    "i686-linux"
    "x86_64-linux"
    "x86_64-darwin"
  ];

  # takes a string, creates a set with 2 keys: name, and ext where name is the string before "." and ext is the string after
  parseFilename = str:
    let
      parts = builtins.match "(.*)\\.(.*)" (builtins.baseNameOf str);
    in
    if parts == null then
      { name = builtins.baseNameOf str; ext = ""; }
    else
      { name = builtins.elemAt parts 0; ext = builtins.elemAt parts 1; };

  mapfiles = dir:
    let
      files = builtins.attrNames (builtins.readDir dir);
    in
    builtins.listToAttrs (builtins.map (file: { name = (parseFilename file).name; value = "${dir}/${file}"; }) files);

  # takes a string with elements split by a comma such as "alice,bob" and will create list [ alice bob ]
  splitToList = string: builtins.filter builtins.isString (builtins.split "," string);

  # takes a directory and a prefix. Returns a list of strings with the names of the files and folders and prepends each element with prefix.
  autoImport = dir:
    let
      workingDirectory = dir;
    in
    lib.forEach (builtins.attrNames (builtins.readDir workingDirectory)) (dirname: workingDirectory + /${dirname});
}
