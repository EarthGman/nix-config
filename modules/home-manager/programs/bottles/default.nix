{ pkgs, config, lib, ... }:
{
  options.programs.bottles.enable = lib.mkEnableOption "enable wine and bottles";
  config = lib.mkIf config.programs.bottles.enable {
    home.packages = with pkgs; [
      bottles
    ];
  };
}
