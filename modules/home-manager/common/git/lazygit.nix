{ pkgs, config, lib, ... }:
{
  options.lazygit.enable = lib.mkEnableOption "enable lazygit";
  config = lib.mkIf config.lazygit.enable {
    home.packages = with pkgs; [
      lazygit
    ];
  };
}