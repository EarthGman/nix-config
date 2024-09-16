{ pkgs, config, lib, ... }:
{
  options.programs.openconnect.enable = lib.mkEnableOption "enable openconnect";
  config = lib.mkIf config.programs.openconnect.enable {
    home.packages = with pkgs; [
      openconnect
    ];
  };
}
