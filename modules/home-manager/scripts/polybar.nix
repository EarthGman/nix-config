{ pkgs, getExe, ... }:
pkgs.writeShellScript "polybar.sh" ''
  ${getExe pkgs.killall} polybar
  sleep 0.1
  if type "xrandr"; then
    for m in $(xrandr --query | grep " connected" | cut -d " " -f1); do
      MONITOR=$m ${getExe pkgs.polybar} --reload bottom &
    done
  else
    ${getExe pkgs.polybar} --reload bottom &
  fi 
''
