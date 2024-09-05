{ pkgs, lib, config, ... }:
{
  options.custom.totem.enable = lib.mkEnableOption "enable totem";
  config = lib.mkIf config.custom.totem.enable {
    home.packages = with pkgs; [
      totem
    ];
  };
}
