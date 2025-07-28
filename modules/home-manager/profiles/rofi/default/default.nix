{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf mkMerge;
  cfg = config.profiles.rofi.default;
in
{
  options.profiles.rofi.default.enable = mkEnableOption "default rofi profile";
  config = mkIf cfg.enable (mkMerge [
    {
      programs.rofi = {
        extraConfig = import ./config.nix { inherit lib config; };
        theme = import ./theme.nix { inherit config; };
        # works on both x11 and wayland
        package = pkgs.rofi-wayland;
      };
      stylix.targets.rofi.enable = true;
    }
    (mkIf config.programs.rofi.enable {
      # TODO script I coped from some random dude on reddit, fix it
      xdg.configFile."rofi/wallpapers.rasi" = {
        text = builtins.readFile ./wallpapers.rasi;
      };
    })
  ]);
}
