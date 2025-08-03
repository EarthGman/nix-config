{
  lib,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf mkMerge;
  cfg = config.profiles.swaync.default;
in
{
  options.profiles.swaync.default = {
    enable = mkEnableOption "default swaync profile";
    config.small = mkEnableOption "special config for smaller monitors < 1920x1080";
  };

  config = mkIf cfg.enable (mkMerge [
    {
      services.swaync = {
        settings = import ./settings.nix { inherit lib; };
        # style = builtins.readFile ./style.css;
      };
    }
    (mkIf cfg.config.small {
      services.swaync.settings = {
        control-center-width = 300;
        control-center-height = 450;
      };
    })
  ]);
}
