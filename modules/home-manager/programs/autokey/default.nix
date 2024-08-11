{ pkgs, config, lib, ... }:
{
  options.autokey.enable = lib.mkEnableOption "enable autokey";
  config = lib.mkIf config.autokey.enable {
    home.packages = with pkgs; [
      autokey
    ];
  };
}
