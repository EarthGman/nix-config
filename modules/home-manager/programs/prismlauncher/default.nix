{ pkgs, config, lib, ... }:
{
  options.prismlauncher.enable = lib.mkEnableOption "enable prismlauncher";
  config = lib.mkIf config.prismlauncher.enable {
    home.packages = with pkgs.unstable; [
      prismlauncher
    ];
  };
}
