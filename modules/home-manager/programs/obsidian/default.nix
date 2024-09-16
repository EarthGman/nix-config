{ pkgs, config, lib, ... }:
{
  options.programs.obsidian.enable = lib.mkEnableOption "enable obsidian";
  config = lib.mkIf config.programs.obsidian.enable {
    home.packages = with pkgs; [
      obsidian
    ];
  };
}
