{ pkgs, config, lib, ... }:
{
  options.remmina.enable = lib.mkEnableOption "enable remmina";
  config = lib.mkIf config.remmina.enable {
    home.packages = with pkgs; [
      remmina
    ];
  };
}
