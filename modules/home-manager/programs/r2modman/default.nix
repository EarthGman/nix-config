{ pkgs, lib, config, ... }:
{
  options.programs.r2modman.enable = lib.mkEnableOption "enable r2modman, an alternative to thunderstore";
  config = lib.mkIf config.programs.r2modman.enable {
    home.packages = [ pkgs.r2modman ];
  };
}
