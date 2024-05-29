{ pkgs, config, lib, ... }:
{
  options.openshot.enable = lib.mkEnableOption "enable openshot";
  config = lib.mkIf config.openshot.enable {
    home.packages = with pkgs; [
      openshot-qt
    ];
  };
}
