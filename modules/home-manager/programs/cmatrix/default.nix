{ pkgs, config, lib, ... }:
{
  options.programs.cmatrix.enable = lib.mkEnableOption "enable cmatrix a command line random bonsai tree generator";
  config = lib.mkIf config.programs.cmatrix.enable {
    home.packages = with pkgs; [
      cmatrix
    ];
  };
}
