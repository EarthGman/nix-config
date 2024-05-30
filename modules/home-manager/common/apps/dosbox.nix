{ pkgs, config, lib, ... }:
{
  options.dosbox.enable = lib.mkEnableOption "enable dosbox";
  config = lib.mkIf config.dosbox.enable {
    home.packages = with pkgs; [
      dosbox-staging
    ];
  };
}
