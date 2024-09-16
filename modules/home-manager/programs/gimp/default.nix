{ pkgs, config, lib, ... }:
{
  options.programs.gimp.enable = lib.mkEnableOption "enable gimp";
  config = lib.mkIf config.programs.gimp.enable {
    home.packages = with pkgs; [
      gimp
    ];
  };
}
