{ pkgs, lib, config, ... }:
let
  inherit (lib) getExe;
  inherit (pkgs) writeScript;

  screenshot_timestamp = "$(date +%F_%T)";
  screenshot_output = "${config.home.homeDirectory}/Pictures/Screenshots/Screenshot-${screenshot_timestamp}.png";
in
{
  polybar = writeScript "polybar.sh" ''
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
  hyprland_windows = writeScript "hyprland-window-creation-emulator.sh" ''
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

  take_screenshot_selection = writeScript "take-screenshot-selection-xorg.sh" ''
      output="${screenshot_output}"
      if [ ! -d ${config.home.homeDirectory}/Pictures/Screenshots ]; then
        mkdir -p ${config.home.homeDirectory}/Pictures/Screenshots
      fi

      ${getExe pkgs.maim} -s | ${getExe pkgs.xclip} -selection clipboard -t image/png
      ${getExe pkgs.xclip} -selection clipboard -t image/png -o > $output

    if [ -s $output ]; then
      dunstify 'Screenshot saved to ~/Pictures/Screenshots'
    else
      rm $output
    fi
  '';

  take_screenshot = writeScript "take_screenshot_xorg.sh" ''
    output="${screenshot_output}"

    if [ ! -d ${config.home.homeDirectory}/Pictures/Screenshots ]; then
      mkdir -p ${config.home.homeDirectory}/Pictures/Screenshots
    fi

    if ${getExe pkgs.maim} | ${getExe pkgs.xclip} -selection clipboard -t image/png; ${getExe pkgs.xclip} -selection clipboard -t image/png -o > $output; then
      dunstify 'Screenshot saved to ~/Pictures/Screenshots'
    fi
  '';

  take_screenshot_window = writeScript "take_screenshot_window_xorg.sh" ''
    output="${screenshot_output}"

    if [ ! -d ${config.home.homeDirectory}/Pictures/Screenshots ]; then
      mkdir -p ${config.home.homeDirectory}/Pictures/Screenshots
    fi

    if ${getExe pkgs.maim} -i $(${getExe pkgs.xdotool} getactivewindow) | ${getExe pkgs.xclip} -selection clipboard -t image/png; ${getExe pkgs.xclip} -selection clipboard -t image/png -o > $output; then
      dunstify 'Screenshot saved to ~/Pictures/Screenshots'
    fi
  '';
}
