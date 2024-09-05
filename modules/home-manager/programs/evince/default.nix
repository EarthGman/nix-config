{ pkgs, config, lib, ... }:
{
  options.custom.evince.enable = lib.mkEnableOption "enable evince";
  config = lib.mkIf config.custom.evince.enable {
    home.packages = with pkgs; [
      evince
    ];
  };
}
