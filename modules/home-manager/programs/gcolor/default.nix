{ pkgs, config, lib, ... }:
{
  options.custom.gcolor.enable = lib.mkEnableOption "enable gcolor";
  config = lib.mkIf config.custom.gcolor.enable {
    home.packages = with pkgs; [
      gcolor3
    ];
  };
}
