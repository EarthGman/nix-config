{ pkgs, config, lib, ... }:
{
  options.brave.enable = lib.mkEnableOption "enable brave";
  config = lib.mkIf config.brave.enable {
    home.packages = with pkgs; [
      brave
    ];
  };
}
