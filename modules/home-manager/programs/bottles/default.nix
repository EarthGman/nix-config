{ pkgs, config, lib, ... }:
{
  options.custom.bottles.enable = lib.mkEnableOption "enable wine and bottles";
  config = lib.mkIf config.custom.bottles.enable {
    home.packages = with pkgs; [
      bottles
    ];
  };
}
