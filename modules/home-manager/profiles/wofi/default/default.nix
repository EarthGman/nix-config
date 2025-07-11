{ lib, config, ... }:
let
  inherit (lib) mkEnableOption mkIf mkMerge;
  cfg = config.profiles.wofi.default;
in
{
  options.profiles.wofi.default.enable = mkEnableOption "default wofi profile";

  config = mkIf cfg.enable (mkMerge [
    {
      programs.wofi = {
        # settings = import ./settings.nix;
        # style = builtins.readFile ./style.css;
      };
    }
  ]);
}
