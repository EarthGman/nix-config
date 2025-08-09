{ lib, config, ... }:
{
  options.gman.suites.reddit-ricing.enable =
    lib.mkEnableOption "programs typically seen on reddit's r/unixporn";

  config = lib.mkIf config.gman.suites.reddit-ricing.enable {
    programs = {
      cmatrix.enable = true;
      cbonsai.enable = true;
      sl.enable = true;
      cava.enable = true;
      pipes.enable = true;
    };
  };
}
