{ pkgs, config, lib, ... }:
{
  options.custom.openshot.enable = lib.mkEnableOption "enable openshot video editor";
  config = lib.mkIf config.custom.openshot.enable {
    home.packages = with pkgs; [
      openshot-qt
    ];
  };
}
