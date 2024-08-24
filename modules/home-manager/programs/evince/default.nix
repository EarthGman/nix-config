{ pkgs, config, lib, ... }:
{
  options.evince.enable = lib.mkEnableOption "enable evince";
  config = lib.mkIf config.evince.enable {
    home.packages = with pkgs; [
      evince
    ];
  };
}
