{ pkgs, lib, config, desktop, ... }:
let
  inherit (lib) mkDefault mkForce;
  scripts = import ../../../scripts { inherit pkgs lib config; };
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
  modes = {
    resize = {
      Up = "resize grow height 10px";
      Down = "resize shrink height 10 px";
      Escape = "mode default";
      Left = "resize grow width 10 px";
      Return = "mode default";
      Right = "resize shrink width 10 px";
      h = "resize grow width 10px";
      j = "resize shrink height 10px";
      k = "resize grow height 10px";
      l = "resize shrink width 10px";
    };
  };
  gaps = {
    inner = mkDefault 2;
    outer = mkDefault 2;
  };
  window = {
    hideEdgeBorders = mkDefault "none";
    titlebar = mkDefault false;
  };
}
