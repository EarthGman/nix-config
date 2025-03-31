{ pkgs, config, fetchurl, wallpapers, ... }:
pkgs.writeScript "omori-calendar-project.sh" ''
  #!${pkgs.bash}/bin/bash
  January="${fetchurl wallpapers.omori-january}"
  February="${fetchurl wallpapers.omori-february}"
  March="${fetchurl wallpapers.omori-march}"
  April="${fetchurl wallpapers.omori-april}"
  May="${fetchurl wallpapers.omori-may}"
  June="${fetchurl wallpapers.omori-june}"
  July="${fetchurl wallpapers.omori-july}"
  August="${fetchurl wallpapers.omori-august}"
  September="${fetchurl wallpapers.omori-september}"
  October="${fetchurl wallpapers.omori-october}"
  November="${fetchurl wallpapers.omori-november}"
  December="${fetchurl wallpapers.omori-december}"

  MONTH=$(date +"%B")

  if [ -n "$WAYLAND_DISPLAY" ]; then
    userid=$(id -u)
    socket_path="/run/user/$userid/swww-wayland-1.sock"

    for ((i=1; i<=30; i++ )); do
      if [ -e "$socket_path" ]; then
        swww img "''${!MONTH}"
        exit 0
      fi
      sleep 0.1
    done

  else
    feh --no-fehbg --bg-${config.services.fehbg.settings.scale-mode} "''${!MONTH}"
  fi

  echo "Set wallpaper: ''${MONTH} for desktop: ''${XDG_CURRENT_DESKTOP}"  
''
