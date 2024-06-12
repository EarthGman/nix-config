{ pkgs, config, lib, ... }:
{
  options.freeoffice.enable = lib.mkEnableOption "enable freeoffice";
  config = lib.mkIf config.freeoffice.enable {
    home.packages = with pkgs; [
      freeoffice
    ];
  };
}
