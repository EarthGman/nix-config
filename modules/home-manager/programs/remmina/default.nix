{ pkgs, config, lib, ... }:
{
  options.programs.remmina.enable = lib.mkEnableOption "enable remmina";
  config = lib.mkIf config.programs.remmina.enable {
    home.packages = with pkgs; [
      remmina
    ];
  };
}
