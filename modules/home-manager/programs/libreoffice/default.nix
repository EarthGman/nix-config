{ pkgs, config, lib, ... }:
{
  options.custom.libreoffice.enable = lib.mkEnableOption "enable libreoffice";
  config = lib.mkIf config.custom.libreoffice.enable {
    home.packages = with pkgs; [
      libreoffice
    ];
  };
}
