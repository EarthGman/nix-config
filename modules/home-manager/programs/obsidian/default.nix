{ pkgs, config, lib, ... }:
{
  options.custom.obsidian.enable = lib.mkEnableOption "enable obsidian";
  config = lib.mkIf config.custom.obsidian.enable {
    home.packages = with pkgs; [
      obsidian
    ];
  };
}
