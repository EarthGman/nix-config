{ self, inputs, outputs, ... }:
let
  inherit (outputs) lib;
in
{
  mkHost =
    { hostName
    , cpu ? null
    , gpu ? null
    , users ? [ ]
    , desktop ? null
    , server ? false
    , vm ? false
    , iso ? false
    , platform ? "x86_64-linux"
    , stateVersion ? "24.11"
    }:
    let
      inherit (builtins) fromJSON readFile;
      wallpapers = fromJSON (readFile inputs.wallpapers.outPath);
      icons = fromJSON (readFile inputs.icons.outPath);
      binaries = fromJSON (readFile inputs.binaries.outPath);
      keys = import ../keys.nix;
    in
    lib.nixosSystem {
      specialArgs = {
        inherit self platform inputs outputs lib wallpapers icons binaries keys hostName cpu gpu users desktop server vm stateVersion;
      };
      modules =
        let
          inherit (lib) optionals autoImport;
          inherit (builtins) pathExists;
          cd-dvd =
            if (desktop == null) then
              inputs.nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
            else
              inputs.nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-graphical-calamares.nix";
          qemu-guest = inputs.nixpkgs + "/nixos/modules/profiles/qemu-guest.nix";
          desktop-setup = self + /profiles/nixos/desktop.nix;
          iso-setup = self + /profiles/nixos/iso.nix;
          server-setup = self + /profiles/nixos/server;
          host =
            # has extra configuration?
            if (pathExists ../hosts/${hostName})
            then
              [ ../hosts/${hostName} ]
            else
              [ ];
          nixosModules = autoImport ../modules/nixos;
          nixosUsers =
            # has user?
            if (pathExists ../hosts/${hostName}/users)
            then
              autoImport ../hosts/${hostName}/users
            else [ ];
        in
        nixosModules
        ++ nixosUsers
        ++ host
        ++ optionals iso [ cd-dvd iso-setup ]
        ++ optionals vm [ qemu-guest ]
        ++ optionals (desktop != null) [ desktop-setup ]
        ++ optionals server [ server-setup ];
    };

  forAllSystems = lib.genAttrs [
    "aarch64-linux"
    "aarch64-darwin"
    "i686-linux"
    "x86_64-linux"
    "x86_64-darwin"
  ];

  # takes a string and seperator. Returns a list of elements split by the seperator
  # EX stringToList "alice,bob" "," -> [ "alice" "bob" ]
  stringToList = string: seperator: builtins.filter builtins.isString (builtins.split "${seperator}" string);

  # read a directory and return a list of all filenames inside
  autoImport = dir:
    let
      workingDirectory = dir;
    in
    lib.forEach (builtins.attrNames (builtins.readDir workingDirectory)) (dirname: workingDirectory + /${dirname});
}
