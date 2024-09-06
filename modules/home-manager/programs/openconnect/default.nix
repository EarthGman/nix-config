{ pkgs, config, lib, ... }:
{
  options.custom.openconnect.enable = lib.mkEnableOption "enable openconnect";
  config = lib.mkIf config.custom.openconnect.enable {
    home.packages = with pkgs; [
      openconnect
    ];
  };
}
