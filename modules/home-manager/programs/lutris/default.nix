{ pkgs, config, lib, ... }:
{
  options.lutris.enable = lib.mkEnableOption "enable lutris";
  config = lib.mkIf config.lutris.enable {
    home.packages = with pkgs; [
      lutris
    ];
  };
}
