{ pkgs, config, lib, ... }:
{
  options.custom.dosbox.enable = lib.mkEnableOption "enable dosbox";
  config = lib.mkIf config.custom.dosbox.enable {
    home.packages = with pkgs; [
      dosbox-staging
    ];
  };
}
