{ pkgs, lib, ... }:
let
  inherit (lib) getExe;
in
{
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
}
