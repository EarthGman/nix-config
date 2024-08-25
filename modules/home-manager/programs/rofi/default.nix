{ lib, config, ... }:
{
  options.rofi.enable = lib.mkEnableOption "enable rofi";
  config = lib.mkIf config.rofi.enable {
    programs = {
      rofi = {
        enable = true;
        extraConfig = import ./config.nix;
      };
    };
  };
}
