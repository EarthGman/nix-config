{ pkgs, config, lib, ... }:
{
  options.pamixer.enable = lib.mkEnableOption "enable pamixer";
  config = lib.mkIf config.pamixer.enable {
    home.packages = with pkgs; [
      pamixer
    ];
  };
}
