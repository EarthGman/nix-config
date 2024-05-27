{ pkgs, config, lib, ... }:
{
  options.zed.enable = lib.mkEnableOption "enable zed";
  config = lib.mkIf config.zed.enable {
    home.packages = with pkgs; [
      zed-editor
    ];
  };
}
