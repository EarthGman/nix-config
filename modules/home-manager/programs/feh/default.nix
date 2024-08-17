{ pkgs, config, lib, ... }:
{
  options.feh.enable = lib.mkEnableOption "enable feh";
  config = lib.mkIf config.feh.enable {
    home.packages = with pkgs; [
      feh
    ];
  };
}
