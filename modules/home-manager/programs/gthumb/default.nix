{ pkgs, config, lib, ... }:
{
  options.programs.gthumb.enable = lib.mkEnableOption "enable gthumb image viewer for gnome";
  config = lib.mkIf config.programs.gthumb.enable {
    home.packages = with pkgs; [
      gthumb
    ];
  };
}
