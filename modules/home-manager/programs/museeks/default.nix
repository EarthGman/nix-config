{ pkgs, config, lib, ... }:
{
  options.custom.museeks.enable = lib.mkEnableOption "enable museeks";
  config = lib.mkIf config.custom.museeks.enable {
    home.packages = with pkgs; [
      museeks
    ];
  };
}
