{ pkgs, lib, config, ... }:
{
  options.programs.simple-scan.enable = lib.mkEnableOption "enable simple-scan a document scanning app";
  config = lib.mkIf config.programs.simple-scan.enable {
    home.packages = with pkgs; [
      simple-scan
    ];
  };
}
