{ pkgs, lib, config, ... }:
{
  options.custom.switcheroo.enable = lib.mkEnableOption "enable switcheroo";
  config = lib.mkIf config.custom.switcheroo.enable {
    home.packages = with pkgs; [
      switcheroo
    ];
  };
}
