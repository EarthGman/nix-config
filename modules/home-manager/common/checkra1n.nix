{ pkgs, config, lib, ... }:
{
  options.checkra1n.enable = lib.mkEnableOption "enable checkra1n";
  config = lib.mkIf config.checkra1n.enable {
    home.packages = with pkgs; [
      checkra1n
    ];
  };
}
