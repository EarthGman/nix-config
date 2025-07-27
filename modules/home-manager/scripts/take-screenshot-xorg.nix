{ pkgs, getExe, ... }:
pkgs.writeShellScript "take_screenshot_xorg.sh" ''
  screenshot_dir=$XDG_SCREENSHOTS_DIR
  saved=false

  if [ ! -d $screenshot_dir ]; then
    mkdir -p $screenshot_dir
  fi

  timestamp=$(${pkgs.coreutils-full}/bin/date +%F_%T)
  output="$screenshot_dir/''${timestamp}.png"
  mode="$1"

  case $mode in
    screen)
      if ${getExe pkgs.maim} | ${getExe pkgs.xclip} -selection clipboard -t image/png; ${getExe pkgs.xclip} -selection clipboard -t image/png -o > $output; then
        saved=true
      fi
      ;;

    selection)
      if ${getExe pkgs.maim} -s | ${getExe pkgs.xclip} -selection clipboard -t image/png; ${getExe pkgs.xclip} -selection clipboard -t image/png -o > $output; then
        saved=true
      fi
      ;;

    window)
      if ${getExe pkgs.maim} -i $(${getExe pkgs.xdotool} getactivewindow) | ${getExe pkgs.xclip} -selection clipboard -t image/png; ${getExe pkgs.xclip} -selection clipboard -t image/png -o > $output; then
        saved=true
      fi
      ;;
  esac

  if [ $saved == "true" ]; then
    ${pkgs.libnotify}/bin/notify-send "Screenshot saved to ~/Pictures/screenshots
  ''${timestamp}.png"
    exit 0
  fi
  exit 1
''
