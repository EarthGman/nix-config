{ pkgs, config, lib, ... }:
{
  options.flips.enable = lib.mkEnableOption "enable flips";
  config = lib.mkIf config.flips.enable {
    home.packages = with pkgs; [
      flips
    ];
  };
}
