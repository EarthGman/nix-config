{ pkgs, config, lib, ... }:
{
  options.programs.moonlight.enable = lib.mkEnableOption "enable moonlight";
  config = lib.mkIf config.programs.moonlight.enable {
    home.packages = with pkgs; [
      moonlight-qt
    ];
  };
}
