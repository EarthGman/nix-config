{ pkgs, config, lib, ... }:
{
  options.custom.zoom.enable = lib.mkEnableOption "enable zoom";
  config = lib.mkIf config.custom.zoom.enable {
    home.packages = with pkgs; [
      zoom-us
    ];
  };
}
