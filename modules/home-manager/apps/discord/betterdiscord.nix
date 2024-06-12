{ pkgs, config, lib, ... }:
{
  options.betterdiscord.enable = lib.mkEnableOption "enable betterdiscord";
  config = lib.mkIf config.betterdiscord.enable {
    home.packages = with pkgs; [
      betterdiscordctl
      betterdiscord-installer
    ];
  };
}
