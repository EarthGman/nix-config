{ pkgs, config, lib, ... }:
{
  options.wezterm.enable = lib.mkEnableOption "enable wezterm";
  config = lib.mkIf config.wezterm.enable {
    programs.wezterm = {
      enable = true;
      extraConfig = import ./settings.nix;
    };
  };
}
