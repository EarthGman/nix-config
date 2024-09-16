{ pkgs, config, lib, ... }:
{
  options.programs.lutris.enable = lib.mkEnableOption "enable lutris";
  config = lib.mkIf config.programs.lutris.enable {
    home.packages = with pkgs; [
      lutris
    ];
  };
}
