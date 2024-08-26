{ pkgs, config, lib, ... }:
{
  options.ghex.enable = lib.mkEnableOption "enable ghex";
  config = lib.mkIf config.ghex.enable {
    home.packages = with pkgs; [
      gnome.ghex
    ];
  };
}
