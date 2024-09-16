{ pkgs, config, lib, ... }:
{
  options.programs.zoom.enable = lib.mkEnableOption "enable zoom";
  config = lib.mkIf config.programs.zoom.enable {
    home.packages = with pkgs; [
      zoom-us
    ];
  };
}
