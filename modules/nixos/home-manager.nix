{ self, inputs, outputs, config, hostName, lib, users, icons, wallpapers, desktop, stateVersion, ... }:
let
  inherit (lib) mkIf types genAttrs mkOption mkEnableOption;
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
      default = self + /profiles/home-manager;
    };
  };

  config = mkIf cfg.enable {
    home-manager = {
      users = genAttrs users
        (username: {
          imports = [
            outputs.homeManagerModules
          ] ++ [
            (config.home-manager.profilesDir + "/${username}.nix")
          ];
          home = {
            inherit username stateVersion;
          };
        });
      extraSpecialArgs = {
        inherit self inputs outputs wallpapers icons hostName desktop stateVersion;
      };
    };
  };
}