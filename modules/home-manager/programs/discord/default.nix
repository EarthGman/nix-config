{ pkgs, config, lib, ... }:
{
  options.discord.enable = lib.mkEnableOption "enable discord";
  config = lib.mkIf config.discord.enable {
    home.packages = with pkgs.unstable; [
      (discord.override {
        withOpenASAR = true;
        withVencord = true;
      })
      vesktop
    ];
  };
}
