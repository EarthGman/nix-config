{ pkgs, config, lib, ... }:
{
  options.custom.gthumb.enable = lib.mkEnableOption "enable gthumb image viewer for gnome";
  config = lib.mkIf config.custom.gthumb.enable {
    home.packages = with pkgs; [
      gthumb
    ];
  };
}
