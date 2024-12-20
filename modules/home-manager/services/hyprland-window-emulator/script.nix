{ pkgs, lib, ... }:
let
  inherit (pkgs) writeScript;
  inherit (lib) getExe;
in

writeScript "hyprland-window-creation-emulator.sh" ''
  #!${getExe pkgs.bash}

  # Determine the appropriate message command based on $XDG_CURRENT_DESKTOP
  if [ "$XDG_CURRENT_DESKTOP" = "none+i3" ]; then
    msg_cmd="i3-msg"
  elif [ "$XDG_CURRENT_DESKTOP" = "sway:wlroots" ]; then
    msg_cmd="swaymsg"
  else
    echo "Error: Unsupported desktop environment: $XDG_CURRENT_DESKTOP"
    exit 1
  fi

  adjust_split_mode() {
    eval $($msg_cmd -t get_tree | jq -r '
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
      $msg_cmd split v > /dev/null
    else
      $msg_cmd split h > /dev/null
    fi
  }

  $msg_cmd -t subscribe -m '[ "window" ]' | while read -r _; do
    adjust_split_mode
  done
''
