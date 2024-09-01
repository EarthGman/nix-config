{ self, pkgs, config, lib, hostname, username, ... }:
let
  inherit (lib) mkDefault mkForce optionals;
  wp = config.stylix.image;
in
{
  networkmanager_dmenu.enable = mkDefault true;
  pavucontrol.enable = mkDefault true;
  bustle.enable = mkDefault true;
  flameshot.enable = mkDefault true;
  polybar.enable = mkDefault true;
  gnome-system-monitor.enable = mkDefault true;
  vlc.enable = mkDefault true;
  nautilus.enable = mkDefault true;
  rofi.enable = mkDefault true;
  evince.enable = mkDefault true;
  gnome-calculator.enable = mkDefault true;

  xsession.windowManager.i3 = {
    enable = true;
    config = {
      bars = mkForce [ ];
      modifier = "Mod4";
      floating.modifier = "Mod4";
      terminal = "kitty";
      workspaceAutoBackAndForth = true;
      keybindings = import ./keybinds.nix { inherit pkgs config; };
      window = {
        hideEdgeBorders = "both";
      };
      startup = optionals (hostname == "cypher") [
        # position and scale monitors
        {
          command = ''
            xrandr --output DisplayPort-2 --auto --right-of HDMI-A-0 \
                   --output DisplayPort-2 --mode 2560x1440 \
                   --output HDMI-A-0 --mode 1920x1080 --rate 74.97 \
            && ${pkgs.feh}/bin/feh --bg-scale ${wp}
          '';
          always = false;
          notification = false;
        }
      ] ++ optionals (username == "g") [
        # LH mouse
        {
          command = "${pkgs.xorg.xmodmap}/bin/xmodmap ${self}/scripts/.xmodmap";
          always = true;
          notification = false;
        }
      ] ++ [
        {
          command = "${self}/scripts/polybar.sh";
          always = true;
          notification = false;
        }
        {
          command = "${pkgs.picom}/bin/picom --config ~/.config/picom/picom.conf";
          always = false;
          notification = false;
        }
        {
          command = "${pkgs.feh}/bin/feh --bg-scale ${wp}";
          always = true;
          notification = false;
        }
      ];
    };
  };
  xdg.configFile = {
    "picom/picom.conf".text = ''
      vsync = true
    '';
  };
}
