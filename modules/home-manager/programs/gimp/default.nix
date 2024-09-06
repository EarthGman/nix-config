{ pkgs, config, lib, ... }:
{
  options.custom.gimp.enable = lib.mkEnableOption "enable gimp";
  config = lib.mkIf config.custom.gimp.enable {
    home.packages = with pkgs; [
      gimp
    ];
  };
}
