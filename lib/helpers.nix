{ self, outputs, nixos-generators, ... }:
let
  # expose both nixpkgs and self defined lib functions
  inherit (outputs) lib;
  inherit (nixos-generators) nixosGenerate;

in
{
  mkHost =
    { hostName # name your PC
    , bios ? "UEFI" # bios type: one of "legacy" or "UEFI"
    , cpu ? null # cpu brand (amd, intel)
    , gpu ? null # gpu brand (amd, intel, nvidia)
    , users ? [ ] # list of self defined users as strings [ "alice" "bob"]
    , desktop ? null # what desktop? "gnome" "i3" "hyprland" or "i3,hyprland" for multiple.
    , server ? false # is this machine a server
    , vm ? false # is this a virtual machine?
    , iso ? false # is this an ISO?
    , system ? "x86_64-linux" # what cpu architecture?
    , stateVersion ? "25.11" # what version of nixos was this machine initalized?
    , configDir ? null # directory for extra host configuration
    , inputs ? self.inputs # define your flake inputs
    , outputs ? self.outputs # allow access to your flake outputs
    }:
    let
      inherit (builtins) fromJSON readFile;
      wallpapers = fromJSON (readFile inputs.wallpapers.outPath);
      icons = fromJSON (readFile inputs.icons.outPath);
      binaries = fromJSON (readFile inputs.binaries.outPath);
    in
    lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit self system inputs outputs lib wallpapers icons binaries hostName bios cpu gpu users desktop server vm iso stateVersion;
      };
      modules =
        let
          inherit (lib) autoImport;
          inherit (builtins) pathExists;
          inherit (outputs) nixosModules;

          # import specific host configuration
          host = if configDir != null then [ configDir ] else [ ];
          nixosUsers =
            if configDir != null then
              if pathExists (configDir + /users) then
                autoImport (configDir + /users)
              else [ ]
            else [ ];
        in
        [
          nixosModules
          { profiles.default.enable = true; }
        ]
        ++ nixosUsers
        ++ host;
    };

  mkHome =
    { username # your username
    , hostName # name of the host you are on
    , desktop ? null # what desktop? "gnome" "i3" "hyprland" or "i3,hyprland" for multiple.
    , server ? false # is this user on a server
    , vm ? false # is this user on a virtual machine?
    , iso ? false # is this user on an ISO?
    , system ? "x86_64-linux" # what cpu architecture does your host have?
    , stateVersion ? "25.05" # what version of home-manager was this user initalized?
    , profile ? null # directory for your extra user configuration
    , inputs ? self.inputs # define your flake inputs
    , outputs ? self.outputs # allow access to your flake outputs
    }:
    let
      inherit (builtins) fromJSON readFile;
      inherit (lib) optionals;
      inherit (outputs) homeModules;
      wallpapers = fromJSON (readFile inputs.wallpapers.outPath);
      icons = fromJSON (readFile inputs.icons.outPath);
      binaries = fromJSON (readFile inputs.binaries.outPath);
    in
    lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages.${system};
      modules = [
        homeModules
        {
          home = {
            inherit username stateVersion;
            homeDirectory = "/home/${username}";
          };
          profiles.default.enable = true;
        }
      ] ++ optionals (profile != null) [
        profile
      ];
      extraSpecialArgs =
        { inherit self inputs outputs username hostName desktop wallpapers icons binaries server vm iso system stateVersion; };
    };

  mkLXC =
    { inputs ? self.inputs
    , template ? "default" # server profile to enable from modules/nixos/profiles/server
    , extraConfig ? null # Path to additional modules file
    , system ? "x86_64-linux"
    , stateVersion ? "25.05"
    , format ? "proxmox-lxc"
    , ...
    }:
    let
      inherit (lib) optionals mkForce;
    in
    nixosGenerate {
      inherit format system;
      specialArgs = {
        inherit self inputs outputs lib system stateVersion;
      };
      modules = [
        (outputs.nixosModules)
        {
          modules.bootloaders = {
            grub.enable = mkForce false;
            systemd-boot.enable = mkForce false;
          };
          profiles = {
            default.enable = true;
            server.default.enable = true;
            server.${template}.enable = true;
          };
        }
      ] ++
      optionals (extraConfig != null) [ extraConfig ];
    };
}

