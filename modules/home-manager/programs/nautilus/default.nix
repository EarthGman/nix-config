{ pkgs, config, lib, ... }:
{
  options.programs.nautilus.enable = lib.mkEnableOption "enable nautilus";
  config = lib.mkIf config.programs.nautilus.enable {
    home.packages = with pkgs; [
      nautilus
    ];
  };
}
