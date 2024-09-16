{ pkgs, config, lib, ... }:
{
  options.programs.gcolor.enable = lib.mkEnableOption "enable gcolor";
  config = lib.mkIf config.programs.gcolor.enable {
    home.packages = with pkgs; [
      gcolor3
    ];
  };
}
