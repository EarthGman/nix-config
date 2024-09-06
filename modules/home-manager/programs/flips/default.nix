{ pkgs, config, lib, ... }:
{
  options.custom.flips.enable = lib.mkEnableOption "enable flips";
  config = lib.mkIf config.custom.flips.enable {
    home.packages = with pkgs; [
      flips
    ];
  };
}
