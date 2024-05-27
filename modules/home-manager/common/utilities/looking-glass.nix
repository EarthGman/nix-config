{ pkgs, config, lib, ... }:
{
  options.looking-glass.enable = lib.mkEnableOption "enable looking-glass";
  config = lib.mkIf config.looking-glass.enable {
    home.packages = with pkgs; [
      looking-glass-client
    ];
  };
}
