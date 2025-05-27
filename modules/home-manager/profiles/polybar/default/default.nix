{ pkgs, lib, config, ... }:
let
  inherit (lib) mkDefault mkIf getExe mkEnableOption;
  cfg = config.profiles.polybar.default;
in
{
  options.profiles.polybar.default.enable = mkEnableOption "default polybar profile";
  config = mkIf cfg.enable {
    # make sure meslo font is installed
    home.packages = mkIf config.services.polybar.enable (with pkgs; [
      nerd-fonts.meslo-lg
    ]);

    services.polybar = {
      settings = import ./settings.nix { inherit pkgs mkDefault config getExe; };
    };
  };
}
