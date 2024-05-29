{ pkgs, config, lib, ... }:
{
  options.libreoffice.enable = lib.mkEnableOption "enable libreoffice";
  config = lib.mkIf config.libreoffice.enable {
    home.packages = with pkgs; [
      libreoffice
    ];
  };
}
