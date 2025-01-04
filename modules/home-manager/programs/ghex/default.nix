{ pkgs, lib, config, ... }:
{
  options.programs.ghex.enable = lib.mkEnableOption "enable ghex hex editor";
  config = lib.mkIf config.programs.ghex.enable {
    home.packages = [ pkgs.ghex ];
  };
}
