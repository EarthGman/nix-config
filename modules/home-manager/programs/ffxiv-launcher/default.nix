{ pkgs, config, lib, ... }:
{
  options.programs.ffxiv-launcher.enable = lib.mkEnableOption "enable ffxiv-launcher";
  config = lib.mkIf config.programs.ffxiv-launcher.enable {
    home.packages = with pkgs; [
      xivlauncher
    ];
  };
}

