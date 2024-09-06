{ pkgs, config, lib, ... }:
{
  options.custom.pipes.enable = lib.mkEnableOption "enable pipes a useless terminal program";
  config = lib.mkIf config.custom.pipes.enable {
    home.packages = with pkgs; [
      pipes
    ];
  };
}
