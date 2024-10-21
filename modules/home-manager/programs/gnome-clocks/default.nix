{ pkgs, lib, config, ... }:
{
  options.programs.gnome-clocks.enable = lib.mkEnableOption "enable gnome-clocks";
  config = lib.mkIf config.programs.gnome-clocks.enable {
    home.packages = [ pkgs.gnome-clocks ];
  };
}
