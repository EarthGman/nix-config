{ pkgs, lib, config, ... }:
{
  options.programs.sparrow.enable = lib.mkEnableOption "enable sparrow a bitcoin trading app for linux";
  config = lib.mkIf config.programs.sparrow.enable {
    home.packages = with pkgs; [
      sparrow
    ];
  };
}
