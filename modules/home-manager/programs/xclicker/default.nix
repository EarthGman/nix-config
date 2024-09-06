{ pkgs, config, lib, ... }:
{
  options.custom.xclicker.enable = lib.mkEnableOption "enable xclicker";
  config = lib.mkIf config.custom.xclicker.enable {
    home.packages = with pkgs; [
      xclicker
    ];
  };
}
