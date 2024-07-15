{ pkgs, config, lib, ... }:
{
  options.xclicker.enable = lib.mkEnableOption "enable xclicker";
  config = lib.mkIf config.xclicker.enable {
    home.packages = with pkgs; [
      xclicker
    ];
  };
}
