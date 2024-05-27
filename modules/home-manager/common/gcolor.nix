{ pkgs, config, lib, ... }:
{
  options.gcolor.enable = lib.mkEnableOption "enable gcolor";
  config = lib.mkIf config.gcolor.enable {
    home.packages = with pkgs; [
      gcolor3
    ];
  };
}
