{ pkgs, config, lib, ... }:
{
  options.programs.openshot.enable = lib.mkEnableOption "enable openshot video editor";
  config = lib.mkIf config.programs.openshot.enable {
    home.packages = with pkgs; [
      openshot-qt
    ];
  };
}
