{ pkgs, lib, config, ... }:
let
  inherit (lib) mkIf mkEnableOption mkDefault;
  cfg = config.profiles.yazi.default;
in
{
  options.profiles.yazi.default.enable = mkEnableOption "default yazi profile";
  config = mkIf cfg.enable {
    stylix.targets.yazi.enable = true;
    programs.yazi = {
      shellWrapperName = mkDefault "y";
      enableZshIntegration = true;
      settings = import ./settings.nix {
        inherit pkgs lib config;
      };
    };
  };
}
