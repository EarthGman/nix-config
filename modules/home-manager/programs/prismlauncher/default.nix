{ pkgs, config, lib, ... }:
{
  options.custom.prismlauncher.enable = lib.mkEnableOption "enable prismlauncher";
  config = lib.mkIf config.custom.prismlauncher.enable {
    home.packages = with pkgs; [
      prismlauncher
    ];
  };
}
