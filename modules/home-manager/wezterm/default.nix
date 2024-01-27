{ pkgs, config, ... }:
let
  src = config.home.homeDirectory + "/src/nix-config";
  wezterm_lua = src + "/modules/home-manager/wezterm/wezterm.lua";
in
{
  home = {
    file.".config/wezterm/wezterm.lua".source = config.lib.file.mkOutOfStoreSymlink wezterm_lua;
    packages = with pkgs; [
      wezterm
    ];
  };
}
