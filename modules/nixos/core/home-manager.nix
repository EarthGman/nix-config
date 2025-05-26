{ self, inputs, outputs, pkgs, config, hostName, vm, server, system, lib, users, icons, wallpapers, desktop, stateVersion, ... }:
let
  inherit (lib) mkIf optionals types genAttrs mkOption mkEnableOption;
  cfg = config.modules.home-manager;
in
{
  imports = [
    inputs.home-manager.nixosModules.default
  ];

  options = {
    modules.home-manager.enable = mkEnableOption "enable home-manager integration with nixos";
    home-manager.profilesDir = mkOption {
      description = "relative path to the profiles for your home-manager users";
      type = types.path;
      default = self + /home;
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.home-manager ];
    home-manager = {
      users = genAttrs users
        (username: {
          imports = [
            outputs.homeModules
          ] ++ optionals (builtins.pathExists (config.home-manager.profilesDir + "/${username}.nix")) [
            (config.home-manager.profilesDir + "/${username}.nix")
          ];
          home = {
            inherit stateVersion;
          };
          profiles.default.enable = true;
        });
      extraSpecialArgs = {
        inherit self inputs outputs wallpapers icons hostName desktop vm server system stateVersion;
      };
      backupFileExtension = "bak";
    };
  };
}
