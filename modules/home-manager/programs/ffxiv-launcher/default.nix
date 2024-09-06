{ pkgs, config, lib, ... }:
{
  options.custom.ffxiv-launcher.enable = lib.mkEnableOption "enable ffxiv-launcher";
  config = lib.mkIf config.custom.ffxiv-launcher.enable {
    home.packages = with pkgs; [
      xivlauncher
    ];
  };
}

