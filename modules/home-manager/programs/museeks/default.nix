{ pkgs, config, lib, ... }:
{
  options.programs.museeks.enable = lib.mkEnableOption "enable museeks";
  config = lib.mkIf config.programs.museeks.enable {
    home.packages = with pkgs; [
      museeks
    ];
  };
}
