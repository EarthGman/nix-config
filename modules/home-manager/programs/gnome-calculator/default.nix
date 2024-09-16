{ pkgs, config, lib, ... }:
{
  options.programs.gnome-calculator.enable = lib.mkEnableOption "enable gnome-calculator";
  config = lib.mkIf config.programs.gnome-calculator.enable {
    home.packages = with pkgs; [
      gnome-calculator
    ];
  };
}
