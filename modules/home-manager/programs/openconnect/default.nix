{ pkgs, config, lib, ... }:
{
  options.openconnect.enable = lib.mkEnableOption "enable openconnect";
  config = lib.mkIf config.openconnect.enable {
    home.packages = with pkgs; [
      openconnect
    ];
  };
}
