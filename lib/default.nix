{ self, inputs, outputs, ... }:
let
  # expose nixpkgs functions and self defined functions
  inherit (outputs) lib;
in
{
  mkHost =
    { hostName # name your PC
    , cpu ? null # cpu brand (amd, intel)
    , gpu ? null # gpu brand (amd, intel, nvidia)
    , users ? [ ] # list of self defined users as strings [ "alice" "bob"]
    , desktop ? null # what desktop? "gnome" "i3" "hyprland" or "i3,hyprland" for multiple.
    , server ? false # is this machine a server
    , vm ? false # is this a virtual machine?
    , iso ? false # is this an ISO?
    , platform ? "x86_64-linux" # what cpu architecture?
    , stateVersion ? "25.05" # what version of nixos was this machine initalized?
    , configDir ? null # directory for extra host configuration
    }:
    let
      inherit (builtins) fromJSON readFile;
      wallpapers = fromJSON (readFile inputs.wallpapers.outPath);
      icons = fromJSON (readFile inputs.icons.outPath);
      binaries = fromJSON (readFile inputs.binaries.outPath);
    in
    lib.nixosSystem {
      specialArgs = {
        inherit self platform inputs outputs lib wallpapers icons binaries hostName cpu gpu users desktop server vm stateVersion;
      };
      modules =
        let
          inherit (lib) optionals autoImport;
          inherit (builtins) pathExists;
          inherit (outputs) nixosProfiles;
          cd-dvd =
            if (desktop == null) then
              inputs.nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
            else
              inputs.nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-graphical-calamares.nix";
          qemu-guest = inputs.nixpkgs + "/nixos/modules/profiles/qemu-guest.nix";
          desktop-setup = nixosProfiles.desktop;
          iso-setup = nixosProfiles.iso;
          server-setup = nixosProfiles.server;
          host = if configDir != null then [ configDir ] else [ ];
          nixosModules = [ outputs.nixosModules ];
          nixosUsers =
            if configDir != null then
              if pathExists (configDir + /users) then
                autoImport (configDir + /users)
              else [ ]
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
