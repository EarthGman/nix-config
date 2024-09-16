{ pkgs, lib, config, ... }:
{
  options.programs.totem.enable = lib.mkEnableOption "enable totem";
  config = lib.mkIf config.programs.totem.enable {
    home.packages = with pkgs; [
      totem
    ];
  };
}
