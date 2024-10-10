{ pkgs, lib, config, ... }:
{
  options.programs.sl.enable = lib.mkEnableOption "enable sl";
  config = lib.mkIf config.programs.sl.enable {
    home.packages = with pkgs; [
      sl
    ];
  };
}
