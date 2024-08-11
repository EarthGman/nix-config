{ pkgs, config, lib, ... }:
{
  options.ffxiv-launcher.enable = lib.mkEnableOption "enable ffxiv-launcher";
  config = lib.mkIf config.ffxiv-launcher.enable {
    home.packages = with pkgs; [
      xivlauncher
    ];
  };
}

