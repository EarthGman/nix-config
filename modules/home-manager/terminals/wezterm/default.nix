{ pkgs, config, lib, ... }:
let
  src = config.home.homeDirectory + "/src/nix-config";
  wezterm_lua = src + "/modules/home-manager/wezterm/wezterm.lua";
in
{
  options.wezterm.enable = lib.mkEnableOption "enable wezterm";
  config = lib.mkIf config.wezterm.enable {
    home = {
      file.".config/wezterm/wezterm.lua".source = config.lib.file.mkOutOfStoreSymlink wezterm_lua;
      packages = with pkgs; [
        wezterm
      ];
    };
  };
}
