# wrapper for lib.nixosSystem
{ inputs, outputs, ... }:
let
  lib = outputs.lib;
in
{
  hostname, # name your PC
  bios ? "UEFI", # bios type: one of "legacy" or "UEFI"
  cpu ? "intel", # cpu brand (amd, intel)
  gpu ? "intel", # gpu brand (amd, intel, nvidia)
  users ? [ ], # list of self defined users as strings [ "alice" "bob"]
  desktop ? "", # what desktop? "gnome" "hyprland" or "sway"
  server ? false, # is this machine a server
  vm ? false, # is this a virtual machine?
  installer ? false, # is this an installer ISO?
  secretsFile ? null, # path to secrets file
  system ? "x86_64-linux", # what cpu architecture?
  # TODO Update me in november
  stateVersion ? "25.11", # what version of nixos was this machine initalized?
  configDir ? null, # directory for extra host configuration
  extraModules ? [ ], # additional modules from your own flake
  extraSpecialArgs ? { }, # additional arguments passed to nixosSystem SpecialArgs
}:
lib.nixosSystem {
  inherit system; # used for legacy nixos < 22.05, but it doesn't hurt to have it
  specialArgs = {
    inherit lib;
  }
  // extraSpecialArgs;
  modules =
    let
      host =
        if (configDir != null) then if builtins.pathExists (configDir) then [ configDir ] else [ ] else [ ];

      nixosUsers =
        if (host != [ ]) then
          if builtins.pathExists (configDir + "/users") then lib.autoImport (configDir + "/users") else [ ]
        else
          [ ];
    in
    [
      {
        # enable my default module and mixins
        gman = {
          enable = true;
        };

        nixpkgs = {
          overlays = builtins.attrValues outputs.overlays;
        };

        meta = {
          inherit
            hostname
            cpu
            gpu
            bios
            desktop
            users
            vm
            server
            secretsFile
            stateVersion
            ;
        };
      }
    ]
    ++ [ outputs.nixosModules.gman ]
    ++ nixosUsers
    ++ host
    ++ extraModules;
}
