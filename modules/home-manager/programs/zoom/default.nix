{ pkgs, config, lib, ... }:
{
  options.zoom.enable = lib.mkEnableOption "enable zoom";
  config = lib.mkIf config.zoom.enable {
    home.packages = with pkgs; [
      zoom-us
    ];
  };
}
