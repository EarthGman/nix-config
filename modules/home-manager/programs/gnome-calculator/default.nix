{ pkgs, config, lib, ... }:
{
  options.custom.gnome-calculator.enable = lib.mkEnableOption "enable gnome-calculator";
  config = lib.mkIf config.custom.gnome-calculator.enable {
    home.packages = with pkgs; [
      gnome-calculator
    ];
  };
}
