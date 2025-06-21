{ pkgs, lib, config, ... }:
let
  inherit (lib) mkEnableOption mkIf mkDefault;
  cfg = config.profiles.fish.default;
in
{
  options.profiles.fish.default.enable = mkEnableOption "default fish profile";
  config = mkIf cfg.enable {
    stylix.targets.fish.enable = mkDefault true;
    programs.fish = {
      shellAliases = import ../../../../shared/shell-aliases.nix { inherit pkgs lib config; } // {
        hms = "home-manager switch";
      };
    };
  };
}
