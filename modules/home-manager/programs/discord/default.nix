{ pkgs, config, lib, ... }:
{
  options.custom.discord.enable = lib.mkEnableOption "enable discord";
  config = lib.mkIf config.custom.discord.enable {
    home.packages = with pkgs; [
      vesktop
    ];
  };
}
