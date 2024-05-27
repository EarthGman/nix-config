{ pkgs, config, lib, ... }:
{
  options.filezilla.enable = lib.mkEnableOption "enable filezilla";
  config = lib.mkIf config.filezilla.enable {
    home.packages = with pkgs; [
      filezilla
    ];
  };
}
