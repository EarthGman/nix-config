{ pkgs, config, lib, ... }:
let
  inherit (lib) mkDefault mkForce optionals getExe;
  enabled = { enable = mkDefault true; };
  wp = config.stylix.image;
  polybar = pkgs.writeScript "polybar.sh" ''
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
  hyprland_windows = pkgs.writeScript "hyprland-window-creation-emulator.sh" ''
    adjust_split_mode() {
        eval $(i3-msg -t get_tree | jq -r '
            .. | 
            select(.focused? == true) | 
            { width: .rect.width, height: .rect.height } | 
            to_entries | 
            .[] | 
            "\(.key)=\(.value)"
        ')

        if [ -z "$width" ] || [ -z "$height" ]; then
            echo "Error: Unable to retrieve focused window dimensions."
            return
        fi

        if (( width < height )); then
            i3-msg split v
        else
            i3-msg split h
        fi
    }

    while true; do
        i3-msg -t subscribe '[ "window", "workspace" ]' | while read -r _; do
            adjust_split_mode
        done
        sleep 0.1
    done
  '';
in
{
  home.packages = with pkgs; [
    inotify-tools
  ];

  programs = {
    pwvucontrol = enabled;
    rofi = enabled;
  };

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
      modifier = mkDefault "Mod1";
      floating.modifier = mkDefault "Mod1";
      terminal = config.custom.terminal;
      workspaceAutoBackAndForth = true;
      keybindings = import ./keybinds.nix { inherit pkgs config getExe; };
      window = {
        hideEdgeBorders = "both";
        titlebar = mkDefault false;
      };

      startup = [
        {
          command = "${polybar}";
          always = true;
          notification = false;
        }
        {
          command = "${hyprland_windows}";
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
