{ lib, config, ... }:
{
  options.rofi.enable = lib.mkEnableOption "enable rofi";
  config = {
    programs = {
      rofi = {
        enable = true;
        extraConfig = import ./config.nix;
      };
    };
  };
}
