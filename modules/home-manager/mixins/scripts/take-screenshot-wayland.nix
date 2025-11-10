{
  pkgs,
  getExe,
  config,
  ...
}:
pkgs.writeShellScript "take-screenshot-wayland.sh" ''
  screenshot_dir=$XDG_SCREENSHOTS_DIR
  saved=false

  if [ ! -d $screenshot_dir ]; then
    mkdir -p $screenshot_dir
  fi

  timestamp=$(${pkgs.coreutils-full}/bin/date +%F_%T)
  output="$screenshot_dir/''${timestamp}.png"
  mode="$1"

  case $XDG_CURRENT_DESKTOP in
  *"Hyprland"*)
    case $mode in
      selection)
        grimblast --notify copysave area
        ;;
      screen)
        grimblast --notify copysave screen
        ;;
      window)
        grimblast --notify copysave active
        ;;
    esac
    ;;
  *)
    case $mode in
      selection)
        if [ $(${pkgs.procps}/bin/pgrep slurp) ]; then
          exit 0
        fi

        if selection=$(${getExe pkgs.slurp}) && ${getExe pkgs.grim} -g "$selection" - | ${pkgs.wl-clipboard}/bin/wl-copy; then
          ${pkgs.wl-clipboard}/bin/wl-paste > "$output"
            saved=true
        fi
        ;;

      screen)
        if ${getExe pkgs.grim} - | ${pkgs.wl-clipboard}/bin/wl-copy; then 
          ${pkgs.wl-clipboard}/bin/wl-paste > "$output"
          saved=true
        fi
        ;;

      window)
       if ${getExe pkgs.grim} -g "$(swaymsg -t get_tree | jq -j '.. | select(.type?) | select(.focused).rect | "\(.x),\(.y) \(.width)x\(.height)"')" - | ${pkgs.wl-clipboard}/bin/wl-copy; then
         ${pkgs.wl-clipboard}/bin/wl-paste > "$output"
         saved=true
       fi
     esac
     ;;
  esac

  if [ $saved == "true" ]; then
    ${pkgs.libnotify}/bin/notify-send "Screenshot saved to ${config.home.sessionVariables.XDG_SCREENSHOTS_DIR}
  ''${timestamp}.png"
    exit 0
  fi
  exit 1
''
