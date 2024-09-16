{ pkgs, config, lib, ... }:
{
  options.programs.flips.enable = lib.mkEnableOption "enable flips";
  config = lib.mkIf config.programs.flips.enable {
    home.packages = with pkgs; [
      flips
    ];
  };
}
