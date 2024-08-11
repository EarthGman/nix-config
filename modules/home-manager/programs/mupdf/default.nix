{ pkgs, lib, config, ... }:
{
  options.mupdf.enable = lib.mkEnableOption "enable mupdf";
  config = lib.mkIf config.mupdf.enable {
    home.packages = with pkgs; [
      mupdf
    ];
  };
}
