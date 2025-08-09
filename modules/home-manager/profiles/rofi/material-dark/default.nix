{
  lib,
  config,
  ...
}:
let
  cfg = config.gman.profiles.rofi.material-dark;
in
{
  options.gman.profiles.rofi.material-dark.enable = lib.mkEnableOption "material-dark rofi theme";
  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      {
        programs.rofi = {
          extraConfig = import ./config.nix { inherit lib config; };
          theme = import ./theme.nix { inherit config; };
        };
        stylix.targets.rofi.enable = true;
      }
      (lib.mkIf config.programs.rofi.enable {
        # TODO script I coped from some random dude on reddit
        xdg.configFile."rofi/wallpapers.rasi" = {
          text = builtins.readFile ./wallpapers.rasi;
        };
      })
    ]
  );
}
