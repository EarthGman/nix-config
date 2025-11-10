{ inputs, outputs, ... }:
let
  lib = outputs.lib;
in
{
  username,
  hostname,
  desktop ? "",
  system ? "x86_64-linux",
  profile ? null,
  standAlone ? true, # modified automatically, do not change this value
  secretsFile ? null,
  stateVersion ? "25.11",
  extraModules ? [ ],
  extraExtraSpecialArgs ? { },
}:
if standAlone then
  lib.homeManagerConfiguration {
    pkgs = inputs.nixpkgs.legacyPackages.${system};
    modules = [
      outputs.homeModules.gman
      # only import stylix if home manager is standlone due to the automatic propgation of the input through nixos
      inputs.stylix.homeModules.stylix
      {
        gman.enable = true;
        home = {
          inherit username stateVersion;
          homeDirectory = lib.mkDefault "/home/${username}";
        };
        nixpkgs.overlays = builtins.attrValues outputs.overlays;

        meta = {
          inherit
            secretsFile
            desktop
            ;
        };
      }
    ]
    ++ lib.optionals (profile != null) [
      profile
    ]
    ++ extraModules;

    extraSpecialArgs = {
      inherit lib hostname;
    }
    // extraExtraSpecialArgs;
  }

# HM configuration integrated into NixOS
else
  {
    imports = [
      outputs.homeModules.gman
    ]
    ++ lib.optionals (profile != null) [ profile ];

    home = { inherit stateVersion; };

    nixpkgs.overlays = builtins.attrValues outputs.overlays;
    gman.enable = true;

    meta = {
      inherit
        desktop
        secretsFile
        ;
    };
  }
