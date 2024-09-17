{ pkgs, lib, config, ... }:
{
  options.programs.ardour.enable = lib.mkEnableOption "enable ardour, a music DAW";
  config = lib.mkIf config.programs.ardour.enable {
    home.packages = with pkgs; [
      ardour
    ];
  };
}
