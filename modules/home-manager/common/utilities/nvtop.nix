{ pkgs, config, lib, ... }:
{
  options.nvtop.enable = lib.mkEnableOption "enable nvtop";
  config = lib.mkIf config.nvtop.enable {
    home.packages = with pkgs; [
      nvtopPackages.full
    ];
  };
}
