{ pkgs, lib, ... }:
let
  inherit (lib) getExe;
in
''
  ${getExe pkgs.killall} polybar
  sleep 0.1
  if type "xrandr"; then
    for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
      MONITOR=$m polybar --reload bottom &
    done
  else
    polybar --reload bottom &
  fi 
''
