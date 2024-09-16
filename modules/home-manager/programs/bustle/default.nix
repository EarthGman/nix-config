{ pkgs, config, lib, ... }:
{
  options.programs.bustle.enable = lib.mkEnableOption "enable bustle";
  config = lib.mkIf config.programs.bustle.enable {
    home.packages = with pkgs; [
      bustle
    ];
  };
}
