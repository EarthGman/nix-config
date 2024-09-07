{ pkgs, config, lib, ... }:
{
  options.custom.cmatrix.enable = lib.mkEnableOption "enable cmatrix a command line random bonsai tree generator";
  config = lib.mkIf config.custom.cmatrix.enable {
    home.packages = with pkgs; [
      cmatrix
    ];
  };
}
