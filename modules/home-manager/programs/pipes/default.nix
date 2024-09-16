{ pkgs, config, lib, ... }:
{
  options.programs.pipes.enable = lib.mkEnableOption "enable pipes a useless terminal program";
  config = lib.mkIf config.programs.pipes.enable {
    home.packages = with pkgs; [
      pipes
    ];
  };
}
