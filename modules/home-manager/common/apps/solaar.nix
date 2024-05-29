{ pkgs, config, lib, ... }:
{
  options.solaar.enable = lib.mkEnableOption "enable solaar";
  config = lib.mkIf config.solaar.enable {
    home.packages = with pkgs; [
      solaar
    ];
  };
}
