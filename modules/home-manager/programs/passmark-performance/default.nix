{ pkgs, lib, config, ... }:
{
  options.programs.passmark-performancetest.enable = lib.mkEnableOption "enable passmark, a hardware benchmarking tool";
  config = lib.mkIf config.programs.passmark-performancetest.enable {
    home.packages = [ pkgs.passmark-performancetest ];
  };
}
