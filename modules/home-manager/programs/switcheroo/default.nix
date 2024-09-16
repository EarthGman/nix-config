{ pkgs, lib, config, ... }:
{
  options.programs.switcheroo.enable = lib.mkEnableOption "enable switcheroo";
  config = lib.mkIf config.programs.switcheroo.enable {
    home.packages = with pkgs; [
      switcheroo
    ];
  };
}
