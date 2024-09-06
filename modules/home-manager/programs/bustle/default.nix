{ pkgs, config, lib, ... }:
{
  options.custom.bustle.enable = lib.mkEnableOption "enable bustle";
  config = lib.mkIf config.custom.bustle.enable {
    home.packages = with pkgs; [
      bustle
    ];
  };
}
