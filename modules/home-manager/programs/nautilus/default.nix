{ pkgs, config, lib, ... }:
{
  options.nautilus.enable = lib.mkEnableOption "enable nautilus";
  config = lib.mkIf config.nautilus.enable {
    home.packages = with pkgs; [
      gnome.nautilus
    ];
  };
}
