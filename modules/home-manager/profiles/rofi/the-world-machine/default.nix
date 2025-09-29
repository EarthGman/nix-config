{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gman.profiles.rofi.the-world-machine;
in
{
  options.gman.profiles.rofi.the-world-machine.enable =
    lib.mkEnableOption "a rofi theme that mimicks the world machine from oneshot";
  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      {
        programs.rofi = {
          extraConfig = import ./settings.nix;
          theme = import ./theme.nix { inherit config; };
          font = "8\-bit Operator+ " + toString config.stylix.fonts.sizes.popups;
        };
      }
    ]
  );
}
