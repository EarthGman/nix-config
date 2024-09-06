{ pkgs, config, lib, ... }:
{
  options.custom.cbonsai.enable = lib.mkEnableOption "enable cbonsai a command line random bonsai tree generator";
  config = lib.mkIf config.custom.cbonsai.enable {
    home.packages = with pkgs; [
      cbonsai
    ];
  };
}
