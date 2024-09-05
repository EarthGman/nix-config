{ pkgs, config, lib, ... }:
{
  options.custom.nautilus.enable = lib.mkEnableOption "enable nautilus";
  config = lib.mkIf config.custom.nautilus.enable {
    home.packages = with pkgs; [
      nautilus
    ];
  };
}
