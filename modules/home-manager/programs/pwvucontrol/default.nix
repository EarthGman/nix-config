{ pkgs, config, lib, ... }:
{
  options.programs.pwvucontrol.enable = lib.mkEnableOption "enable pavucontrol";
  config = lib.mkIf config.programs.pwvucontrol.enable {
    home.packages = with pkgs; [
      pwvucontrol
    ];
  };
}
