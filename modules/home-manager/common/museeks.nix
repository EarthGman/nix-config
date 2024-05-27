{ pkgs, config, lib, ... }:
{
  options.museeks.enable = lib.mkEnableOption "enable museeks";
  config = lib.mkIf config.museeks.enable {
    home.packages = with pkgs; [
      museeks
    ];
  };
}
