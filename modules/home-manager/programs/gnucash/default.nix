{ pkgs, lib, config, ... }:
{
  options.programs.gnucash.enable = lib.mkEnableOption "enable gnucash, a finance app for personal use or small businesses";
  config = lib.mkIf config.programs.gnucash.enable {
    home.packages = [ pkgs.gnucash ];
  };
}
