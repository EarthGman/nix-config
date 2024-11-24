{ pkgs, lib, config, ... }:
{
  options.programs.gscan2pdf.enable = lib.mkEnableOption "enable gscan2pdf a document scanning app";
  config = lib.mkIf config.programs.gscan2pdf.enable {
    home.packages = with pkgs; [
      gscan2pdf
    ];
  };
}
