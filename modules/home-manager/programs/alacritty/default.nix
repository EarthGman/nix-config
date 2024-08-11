{ pkgs, config, lib, ... }:
{
  options.alacritty.enable = lib.mkEnableOption "alacritty";
  config = lib.mkIf config.alacritty.enable {
    programs.alacritty.enable = true;
  };
}
