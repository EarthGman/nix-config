{ pkgs, config, lib, ... }:
{
  options.davinci-resolve.enable = lib.mkEnableOption "enable davinci-resolve";
  config = lib.mkIf config.davinci-resolve.enable {
    home.packages = with pkgs; [
      davinci-resolve
    ];
  };
}
