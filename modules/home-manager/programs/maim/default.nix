{ pkgs, config, lib, ... }:
{
  options.maim.enable = lib.mkEnableOption "enable maim";
  config = lib.mkIf config.maim.enable {
    home.packages = with pkgs; [
      maim
    ];
  };
}
