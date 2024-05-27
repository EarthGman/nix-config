{ pkgs, config, lib, ... }:
{
  options.powertop.enable = lib.mkEnableOption "enable powertop";
  config = lib.mkIf config.powertop.enable {
    home.packages = with pkgs; [
      powertop
    ];
  };
}
