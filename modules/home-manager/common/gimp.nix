{ pkgs, config, lib, ... }:
{
  options.gimp.enable = lib.mkEnableOption "enable gimp";
  config = lib.mkIf config.gimp.enable {
    home.packages = with pkgs; [
      gimp
    ];
  };
}
