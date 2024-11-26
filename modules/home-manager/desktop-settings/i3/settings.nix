{ pkgs, lib, config, scripts, ... }:
let
  inherit (lib) mkDefault mkForce optionals getExe;
  wp = config.stylix.image;
in
{
  bars = mkForce [ ];
  modifier = mkDefault "Mod4"; # window
  floating.modifier = mkDefault "Mod4"; # window
  terminal = config.custom.terminal;
  workspaceAutoBackAndForth = true;
  keybindings = import ./keybinds.nix { inherit pkgs config getExe scripts; };
  gaps = {
    inner = mkDefault 2;
    outer = mkDefault 2;
  };
  window = {
    hideEdgeBorders = "none";
    titlebar = mkDefault false;
  };

  startup = [
    {
      command = "systemctl --user restart polybar";
      always = true;
      notification = false;
    }
    {
      command = "systemctl --user start hyprland-windows-for-i3";
      always = false;
      notification = false;
    }
    {
      command = "systemctl --user start blueman-applet";
      always = false;
      notification = false;
    }
  ] ++ optionals (!(config.services.omori-calendar-project.enable)) [
    {
      # custom case where the omori calendar project is enabled, disable this
      command = "${getExe pkgs.feh} --bg-scale ${wp}";
      always = true;
      notification = false;
    }
  ];
}
