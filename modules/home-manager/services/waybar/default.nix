{ lib, config, ... }:
{
  options.custom.waybar.enable = lib.mkEnableOption "enable waybar";
  config = lib.mkIf config.custom.waybar.enable {
    programs.waybar = {
      enable = true;
      settings = import ./settings.nix;
    };
  };
}
