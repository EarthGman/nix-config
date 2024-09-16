{ pkgs, config, lib, ... }:
{
  options.programs.discord.enable = lib.mkEnableOption "enable discord";
  config = lib.mkIf config.programs.discord.enable {
    home.packages = with pkgs; [
      vesktop
    ];
  };
}
