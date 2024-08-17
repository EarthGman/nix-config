{ pkgs, config, lib, ... }:
{
  options.networkmanager_dmenu.enable = lib.mkEnableOption "enable networkmanager_dmenu";
  config = lib.mkIf config.networkmanager_dmenu.enable {
    home.packages = with pkgs; [
      networkmanager_dmenu
    ];
  };
}
