{ pkgs, config, lib, ... }:
{
  options.custom.brave.enable = lib.mkEnableOption "enable brave";
  config = lib.mkIf config.custom.brave.enable {
    home.packages = with pkgs; [
      brave
    ];
  };
}
