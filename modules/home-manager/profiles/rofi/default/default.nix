{ pkgs, lib, config, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.profiles.rofi.default;
in
{
  options.profiles.rofi.default.enable = mkEnableOption "default rofi profile";
  config = mkIf cfg.enable {
    programs.rofi = {
      extraConfig = import ./config.nix { inherit lib config; };
      theme = import ./theme.nix { inherit config; };
      package = pkgs.rofi-wayland;
    };
    stylix.targets.rofi.enable = true;
    xdg.configFile."rofi/wallpapers.rasi".text = builtins.readFile ./wallpapers.rasi;
  };
}
