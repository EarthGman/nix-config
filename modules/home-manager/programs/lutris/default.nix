{ pkgs, config, lib, ... }:
{
  options.custom.lutris.enable = lib.mkEnableOption "enable lutris";
  config = lib.mkIf config.custom.lutris.enable {
    home.packages = with pkgs; [
      lutris
    ];
  };
}
