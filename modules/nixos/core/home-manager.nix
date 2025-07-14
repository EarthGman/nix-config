{
  pkgs,
  config,
  hostName,
  vm,
  server,
  wallpapers,
  icons,
  binaries,
  system,
  lib,
  users,
  secretsFile,
  desktop,
  stateVersion,
  extraSpecialArgs,
  ...
}:
let
  inherit (lib)
    mkDefault
    mkIf
    genAttrs
    types
    mkOption
    mkEnableOption
    mkHome
    ;
  cfg = config.modules.home-manager;
in
{
  options = {
    home-manager.profilesDir = mkOption {
      description = "directory containing profiles for HM users";
      type = types.path;
      default = ../../../home;
    };
    modules.home-manager.enable = mkEnableOption "enable home-manager integration with nixos";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.home-manager ];
    home-manager =
      let
        homeProfilesDir = config.home-manager.profilesDir;
      in
      {
        # creates a home-manager configuration using lib/helpers mkHome function for each user specified in users [ ]
        users = genAttrs users (
          username:
          mkHome {
            inherit
              username
              hostName
              desktop
              server
              vm
              secretsFile
              system
              stateVersion
              ;

            profile =
              if builtins.pathExists (homeProfilesDir + "/${username}.nix") then
                (homeProfilesDir + "/${username}.nix")
              else
                null;

            standAlone = false;
          }
        );
        extraSpecialArgs = {
          inherit
            hostName
            desktop
            wallpapers
            icons
            binaries
            secretsFile
            server
            system
            vm
            stateVersion
            ;
        } // extraSpecialArgs;

        backupFileExtension = mkDefault "bak";
      };
  };
}
