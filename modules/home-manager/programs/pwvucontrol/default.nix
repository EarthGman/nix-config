{ pkgs, config, lib, ... }:
{
  options.custom.pwvucontrol.enable = lib.mkEnableOption "enable pavucontrol";
  config = lib.mkIf config.custom.pwvucontrol.enable {
    home.packages = with pkgs; [
      pwvucontrol
    ];
  };
}