{ pkgs, config, lib, ... }:
{
  options.programs.dosbox.enable = lib.mkEnableOption "enable dosbox";
  config = lib.mkIf config.programs.dosbox.enable {
    home.packages = with pkgs; [
      dosbox-staging
    ];
  };
}
