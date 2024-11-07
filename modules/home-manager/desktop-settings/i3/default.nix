{ pkgs, config, lib, ... }:
let
  inherit (lib) mkDefault mkForce optionals getExe;
  enabled = { enable = mkDefault true; };
  wp = config.stylix.image;
  scripts = import ./scripts.nix { inherit pkgs lib config; };
in
{
  programs = {
    pwvucontrol = enabled;
    rofi = enabled;
    i3lock.settings = {
      ignoreEmptyPassword = mkDefault true;
    };
  };

  home.packages = [ pkgs.xorg.xmodmap ];

  services = {
    network-manager-applet = enabled;
    polybar = enabled;
    picom = enabled;
    dunst = enabled;
  };

  xsession.enable = true;
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      bars = mkForce [ ];
      modifier = mkDefault "Mod1"; # alt
      floating.modifier = mkDefault "Mod4"; # window
      terminal = config.custom.terminal;
      workspaceAutoBackAndForth = true;
      keybindings = import ./keybinds.nix { inherit pkgs config getExe scripts; };
      gaps = {
        inner = 2;
        outer = 2;
      };
      window = {
        hideEdgeBorders = "none";
        titlebar = mkDefault false;
      };

      startup = [
        {
          command = "${scripts.polybar}";
          always = true;
          notification = false;
        }
        {
          command = "${scripts.hyprland_windows}";
          always = false;
          notification = false;
        }
        {
          command = "systemctl --user start blueman-applet.service";
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
    };
  };
}
