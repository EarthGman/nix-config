{ pkgs, config, lib, ... }:
{
  options.custom.moonlight.enable = lib.mkEnableOption "enable moonlight";
  config = lib.mkIf config.custom.moonlight.enable {
    home.packages = with pkgs; [
      moonlight-qt
    ];
  };
}
