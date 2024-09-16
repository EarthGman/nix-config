{ pkgs, config, lib, ... }:
{
  options.programs.filezilla.enable = lib.mkEnableOption "enable filezilla";
  config = lib.mkIf config.programs.filezilla.enable {
    home.packages = with pkgs; [
      filezilla
    ];
  };
}
