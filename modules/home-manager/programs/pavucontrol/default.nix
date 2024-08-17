{ pkgs, config, lib, ... }:
{
  options.pavucontrol.enable = lib.mkEnableOption "enable pavucontrol";
  config = lib.mkIf config.pavucontrol.enable {
    home.packages = with pkgs; [
      pavucontrol
    ];
  };
}
