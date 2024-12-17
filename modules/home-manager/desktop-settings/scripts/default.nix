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

  take_screenshot_selection_xorg = writeScript "take-screenshot-selection-xorg.sh" ''
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

  take_screenshot_xorg = writeScript "take_screenshot_xorg.sh" ''
    output="${screenshot_output}"

    if [ ! -d ${config.home.homeDirectory}/Pictures/Screenshots ]; then
      mkdir -p ${config.home.homeDirectory}/Pictures/Screenshots
    fi

    if ${getExe pkgs.maim} | ${getExe pkgs.xclip} -selection clipboard -t image/png; ${getExe pkgs.xclip} -selection clipboard -t image/png -o > $output; then
      dunstify 'Screenshot saved to ~/Pictures/Screenshots'
    fi
  '';

  take_screenshot_window_xorg = writeScript "take_screenshot_window_xorg.sh" ''
    output="${screenshot_output}"

    if [ ! -d ${config.home.homeDirectory}/Pictures/Screenshots ]; then
      mkdir -p ${config.home.homeDirectory}/Pictures/Screenshots
    fi

    if ${getExe pkgs.maim} -i $(${getExe pkgs.xdotool} getactivewindow) | ${getExe pkgs.xclip} -selection clipboard -t image/png; ${getExe pkgs.xclip} -selection clipboard -t image/png -o > $output; then
      dunstify 'Screenshot saved to ~/Pictures/Screenshots'
    fi
  '';

  take_screenshot_selection_wayland = writeScript "take-screenshot-selection-wayland.sh" ''
    if [ ! -d ${config.home.homeDirectory}/Pictures/Screenshots ]; then
      mkdir -p ${config.home.homeDirectory}/Pictures/Screenshots
    fi
    timestamp=$(date +%F_%T)
    output="${config.home.homeDirectory}/Pictures/Screenshots/Screenshot-''${timestamp}.png"

    if selection=$(${getExe pkgs.slurp}) && ${getExe pkgs.grim} -g "$selection" - | ${pkgs.wl-clipboard}/bin/wl-copy; then
      ${pkgs.wl-clipboard}/bin/wl-paste > "$output"
      dunstify 'Screenshot saved to ~/Pictures/Screenshots'
    fi
  '';

  take_screenshot_wayland = writeScript "take-screenshot-wayland.sh" ''
    if [ ! -d ${config.home.homeDirectory}/Pictures/Screenshots ]; then
      mkdir -p ${config.home.homeDirectory}/Pictures/Screenshots
    fi
    timestamp=$(date +%F_%T)
    output="${config.home.homeDirectory}/Pictures/Screenshots/Screenshot-''${timestamp}.png"
    
    if ${getExe pkgs.grim} - | ${pkgs.wl-clipboard}/bin/wl-copy; then
      ${pkgs.wl-clipboard}/bin/wl-paste > "$output"
      dunstify 'Screenshot saved to ~/Pictures/Screenshots'
    fi
  '';
}

