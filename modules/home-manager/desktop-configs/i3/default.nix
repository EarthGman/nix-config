{ pkgs, config, lib, hostName, username, ... }:
let
  inherit (lib) mkDefault mkForce optionals getExe;
  wp = config.stylix.image;
  polybar_sh = pkgs.writeScript "polybar.sh" ''
    ${getExe pkgs.killall} polybar
    sleep 0.1
    if type "xrandr"; then
      for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        MONITOR=$m ${getExe pkgs.polybar} --reload top & \
        MONITOR=$m ${getExe pkgs.polybar} --reload bottom &
      done
    else
      ${getExe pkgs.polybar} --reload top & \
      ${getExe pkgs.polybar} --reload bottom &
    fi 
  '';
in
{
  home.packages = [ pkgs.networkmanager_dmenu ];
  custom = {
    polybar.enable = mkDefault true;
    rofi.enable = mkDefault true;
  };

  xsession.windowManager.i3 = {
    enable = true;
    config = {
      bars = mkForce [ ];
      modifier = mkDefault "Mod4";
      floating.modifier = mkDefault "Mod4";
      terminal = config.custom.terminal;
      workspaceAutoBackAndForth = true;
      keybindings = import ./keybinds.nix { inherit pkgs config getExe; };
      window.hideEdgeBorders = "both";

      startup = optionals (hostName == "cypher") [
        # position and scale monitors
        {
          command = ''
            xrandr --output DisplayPort-2 --auto --right-of HDMI-A-0 \
                   --output DisplayPort-2 --mode 2560x1440 \
                   --output HDMI-A-0 --mode 1920x1080 --rate 74.97 \
            && ${getExe pkgs.feh} --bg-scale ${wp}
          '';
          always = false;
          notification = false;
        }
      ] ++ optionals (username == "g") [
        # LH mouse
        {
          command = "${getExe pkgs.xorg.xmodmap} ./.xmodmap";
          always = true;
          notification = false;
        }
      ] ++ [
        {
          command = "${polybar_sh}";
          always = true;
          notification = false;
        }
        {
          command = "${getExe pkgs.picom} --config ${config.xdg.configHome}/picom/picom.conf";
          always = false;
          notification = false;
        }
        {
          command = "${getExe pkgs.feh} --bg-scale ${wp}";
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
