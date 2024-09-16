{ pkgs, config, lib, ... }:
{
  options.programs.evince.enable = lib.mkEnableOption "enable evince";
  config = lib.mkIf config.programs.evince.enable {
    home.packages = with pkgs; [
      evince
    ];
  };
}
