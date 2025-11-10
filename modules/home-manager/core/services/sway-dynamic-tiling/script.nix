{ pkgs, ... }:
pkgs.writeShellScript "sway-dynamic-tiling.sh" ''

  msg_cmd="swaymsg"

  command -v $msg_cmd >/dev/null || { echo "swaymsg cannot be found. Is sway running?"; exit 1; }

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
      echo "Unable to retrieve focused window dimensions."
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
