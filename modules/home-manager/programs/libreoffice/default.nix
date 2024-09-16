{ pkgs, config, lib, ... }:
{
  options.programs.libreoffice.enable = lib.mkEnableOption "enable libreoffice";
  config = lib.mkIf config.programs.libreoffice.enable {
    home.packages = with pkgs; [
      libreoffice
    ];
  };
}
