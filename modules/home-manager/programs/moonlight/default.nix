{ pkgs, config, lib, ... }:
{
  options.moonlight.enable = lib.mkEnableOption "enable moonlight";
  config = lib.mkIf config.moonlight.enable {
    home.packages = with pkgs; [
      moonlight-qt
    ];
  };
}
