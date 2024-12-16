{ pkgs, lib, config, desktop, ... }:
let
  inherit (lib) mkDefault mkForce;
  scripts = import ../scripts { inherit pkgs lib config; };
in
{
  bars = mkForce [ ];
  modifier = mkDefault "Mod4"; # window
  floating = {
    modifier = mkDefault "Mod4"; # window
    titlebar = mkDefault false;
  };
  menu = "rofi";
  terminal = config.custom.terminal;
  workspaceAutoBackAndForth = mkDefault true;
  keybindings = import ./keybinds.nix { inherit pkgs config lib desktop scripts; };
  gaps = {
    inner = mkDefault 2;
    outer = mkDefault 2;
  };
  window = {
    hideEdgeBorders = mkDefault "none";
    titlebar = mkDefault false;
  };
}
