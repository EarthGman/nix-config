{ lib, config, ... }:
{
  options.home-manager = {
    enable = lib.mkEnableOption "Home Manager integration with nixos";

    profilesDir = lib.mkOption {
      description = "directory containing the home-manager profiles for your users";
      type = lib.types.path;
      default = ../../../home;
    };
  };

  config = lib.mkIf config.home-manager.enable {
    home-manager = {
      backupFileExtension = lib.mkDefault "bak";
      users = lib.genAttrs config.meta.users (
        username:
        lib.mkHome {
          inherit username;
          hostname = config.networking.hostName;
          desktop = config.meta.desktop;
          system = config.meta.system;
          # extra configuration for a username (not required)
          profile =
            if (builtins.pathExists (config.home-manager.profilesDir + "/${username}")) then
              (config.home-manager.profilesDir + "/${username}")
            else
              null;
          standAlone = false;
          stateVersion = config.system.stateVersion;
        }
      );
      extraSpecialArgs = {
        hostname = config.networking.hostName;
      };
    };
  };
}
