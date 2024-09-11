{ pkgs, lib, config, ... }:
{
  options.custom.rofi.enable = lib.mkEnableOption "enable rofi";
  config = lib.mkIf config.custom.rofi.enable {
    programs = {
      rofi = {
        enable = true;
        extraConfig = import ./config.nix;
        theme = import ./theme.nix { inherit config; };
        package = pkgs.rofi-wayland;
      };
    };
  };
}
