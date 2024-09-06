{ pkgs, config, lib, ... }:
{
  options.custom.remmina.enable = lib.mkEnableOption "enable remmina";
  config = lib.mkIf config.custom.remmina.enable {
    home.packages = with pkgs; [
      remmina
    ];
  };
}
