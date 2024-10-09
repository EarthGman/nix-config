{ pkgs, config, lib, hostName, ... }:
let
  inherit (lib) mkDefault mkForce optionals getExe;
  enabled = { enable = mkDefault true; };
  wp = config.stylix.image;
  polybar_sh = pkgs.writeScript "polybar.sh" ''
    ${getExe pkgs.killall} polybar
    sleep 0.1
    if type "xrandr"; then
      for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        MONITOR=$m ${getExe pkgs.polybar} --reload bottom &
      done
    else
      ${getExe pkgs.polybar} --reload bottom &
    fi 
  '';
in
{
  programs = {
    pwvucontrol = enabled;
    rofi = enabled;
  };

  services = {
    network-manager-applet = enabled;
    dunst = enabled;
    polybar = enabled;
    picom = enabled;
  };

  xsession.enable = true;
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      bars = mkForce [ ];
      modifier = mkDefault "Mod1";
      floating.modifier = mkDefault "Mod1";
      terminal = config.custom.terminal;
      workspaceAutoBackAndForth = true;
      keybindings = import ./keybinds.nix { inherit pkgs config getExe; };
      window.hideEdgeBorders = "both";

      startup = [
        {
          command = "${polybar_sh}";
          always = true;
          notification = false;
        }
        {
          command = "systemctl --user start picom.service";
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
