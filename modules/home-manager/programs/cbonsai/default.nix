{ pkgs, config, lib, ... }:
{
  options.programs.cbonsai.enable = lib.mkEnableOption "enable cbonsai a command line random bonsai tree generator";
  config = lib.mkIf config.programs.cbonsai.enable {
    home.packages = with pkgs; [
      cbonsai
    ];
  };
}
