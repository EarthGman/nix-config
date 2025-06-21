{ self, outputs, inputs, ... }:
let
  # expose both nixpkgs and self defined lib functions
  inherit (outputs) lib;
  inherit (inputs) nixos-generators;
  inherit (nixos-generators) nixosGenerate;

  inherit (builtins) fromJSON readFile;

  wallpapers = fromJSON (readFile inputs.wallpapers.outPath);
  icons = fromJSON (readFile inputs.icons.outPath);
  binaries = fromJSON (readFile inputs.binaries.outPath);

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
    , secretsFile ? null # path to secrets file
    , system ? "x86_64-linux" # what cpu architecture?
    , stateVersion ? "25.11" # what version of nixos was this machine initalized?
    , configDir # directory for extra host configuration
    , extraSpecialArgs ? { }
    }:
    lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit
          system
          lib
          wallpapers
          icons
          binaries
          hostName
          bios
          cpu
          gpu
          users
          desktop
          secretsFile
          server
          vm
          iso
          stateVersion
          extraSpecialArgs;
      } // extraSpecialArgs;
      modules =
        let
          inherit (lib) autoImport mkIf;
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
          # some additional logic not inculded in NixOS modules
          {
            profiles.default.enable = true;
            modules.sops.enable = (secretsFile != null);
            sops.defaultSopsFile = mkIf (secretsFile != null) secretsFile;
            imports = if server then [ inputs.srvos.nixosModules.server ] else [ ];
            nixpkgs.overlays = (builtins.attrValues outputs.overlays);
          }
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
    , profile ? null # file for your extra user configuration
    , secretsFile ? null # path to your secrets.yaml
    , standAlone ? true # DO NOT manually set this value
    , extraExtraSpecialArgs ? { }
    }:
    let
      inherit (lib) mkDefault optionals mkIf;
    in
    # create a standalone HM configuration for other distributions using home-manager.lib
    if standAlone then
      lib.homeManagerConfiguration
        {
          pkgs = inputs.nixpkgs.legacyPackages.${system};
          modules = [
            outputs.homeModules
            {
              modules.sops.enable = (secretsFile != null);
              sops.defaultSopsFile = mkIf (secretsFile != null) secretsFile;

              home = {
                inherit username stateVersion;
                homeDirectory = mkDefault "/home/${username}";
              };
              profiles.default.enable = mkDefault true;
              nixpkgs.overlays = (builtins.attrValues outputs.overlays);
            }
          ] ++ optionals (profile != null) [
            profile
          ];
          extraSpecialArgs = {
            inherit
              lib
              username
              hostName
              desktop
              wallpapers
              icons
              binaries
              server
              vm
              iso
              secretsFile
              system
              stateVersion;
          } // extraExtraSpecialArgs;
        }

    # create a HM configuration integrated into NixOS via modules/nixos/core/home-manager.nix
    else {
      imports = [
        outputs.homeModules
      ] ++ optionals (profile != null) [ profile ];

      home = { inherit stateVersion; };

      nixpkgs.overlays = (builtins.attrValues outputs.overlays);

      profiles.default.enable = true;
      modules.sops.enable = (secretsFile != null);
      sops.defaultSopsFile = mkIf (secretsFile != null) secretsFile;
    };

  mkLXC =
    { template # server profile to enable from modules/nixos/profiles/server
    , extraConfig ? null # Path to additional modules file
    , system ? "x86_64-linux"
    , stateVersion ? "25.05"
    , format ? "proxmox-lxc"
    , personal ? false # whether to enable my personal server profile
    , extraSpecialArgs ? { }
    , ...
    }:
    let
      inherit (lib) optionals mkForce;
    in
    nixosGenerate {
      inherit format system;
      specialArgs = {
        inherit
          binaries
          lib
          system
          stateVersion;
      } // extraSpecialArgs;
      modules = [
        (outputs.nixosModules)
        (inputs.srvos.nixosModules.server)
        {
          modules.bootloaders = {
            grub.enable = mkForce false;
            systemd-boot.enable = mkForce false;
          };
          nixpkgs.overlays = (builtins.attrValues outputs.overlays);
          profiles = {
            hardware-tools.enable = false;
            default.enable = true;
            server.default.enable = true;
            server.${template}.enable = true;
            server.personal.enable = personal;
          };
        }
      ] ++
      optionals (extraConfig != null) [ extraConfig ];
    };
}

