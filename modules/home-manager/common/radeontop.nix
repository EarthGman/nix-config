{ pkgs, config, lib, ... }:
{
  options.radeontop.enable = lib.mkEnableOption "enable radeontop";
  config = lib.mkIf config.radeontop.enable {
    home.packages = with pkgs; [
      radeontop
    ];
  };
}
