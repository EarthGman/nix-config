{ pkgs, config, lib, ... }:
{
  options.programs.xclicker.enable = lib.mkEnableOption "enable xclicker";
  config = lib.mkIf config.programs.xclicker.enable {
    home.packages = with pkgs; [
      xclicker
    ];
  };
}
