{ pkgs, lib, config, ... }:
{
  options.switcheroo.enable = lib.mkEnableOption "enable switcheroo";
  config = lib.mkIf config.switcheroo.enable {
    home.packages = with pkgs; [
      switcheroo
    ];
  };
}
