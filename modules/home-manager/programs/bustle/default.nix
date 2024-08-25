{ pkgs, config, lib, ... }:
{
  options.bustle.enable = lib.mkEnableOption "enable bustle";
  config = lib.mkIf config.bustle.enable {
    home.packages = with pkgs; [
      bustle
    ];
  };
}
