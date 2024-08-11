{ pkgs, config, lib, ... }:
{
  options.github-desktop.enable = lib.mkEnableOption "enable github-desktop";
  config = lib.mkIf config.github-desktop.enable {
    home.packages = with pkgs; [
      github-desktop
    ];
  };
}
