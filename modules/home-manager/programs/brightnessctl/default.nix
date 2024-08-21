{ pkgs, config, lib, ... }:
{
  options.brightnessctl.enable = lib.mkEnableOption "enable brightnessctl";
  config = lib.mkIf config.brightnessctl.enable {
    home.packages = with pkgs; [
      brightnessctl
    ];
  };
}
