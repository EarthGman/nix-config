{ pkgs, config, lib, ... }:
{
  options.custom.filezilla.enable = lib.mkEnableOption "enable filezilla";
  config = lib.mkIf config.custom.filezilla.enable {
    home.packages = with pkgs; [
      filezilla
    ];
  };
}
