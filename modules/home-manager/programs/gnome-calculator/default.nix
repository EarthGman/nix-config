{ pkgs, config, lib, ... }:
{
  options.gnome-calculator.enable = lib.mkEnableOption "enable gnome-calculator";
  config = lib.mkIf config.gnome-calculator.enable {
    home.packages = with pkgs; [
      gnome.gnome-calculator
    ];
  };
}
