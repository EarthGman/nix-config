{ pkgs, fetchurl, wallpapers, getExe, ... }:
pkgs.writeScript "set-wallpaper-by-month.sh" ''
  #!${pkgs.bash}/bin/bash
  	January="${fetchurl wallpapers.omori-january}"
  	Feburary="${fetchurl wallpapers.omori-feburary}"
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

  	case "$XDG_CURRENT_DESKTOP" in
  		"Hyprland")
  			for i in {1..5}; do
  			hyprctl clients > /dev/null 2>&1
  			if [ $? -eq 0 ]; then
  				break
  			fi
  			sleep 1
  			done
  			if ! hyprctl clients > /dev/null 2>&1; then
  				exit 1
  			fi

  			CURRENT_CHECK=$(hyprctl hypaper listloaded | grep -i "omori-''${MONTH}")
  			if [ -n "$CURRENT_CHECK" ]; then
  				exit 0
  			fi

  			hyprctl hyprpaper preload "''${!MONTH}"
  			hyprctl hyprpaper wallpaper ",''${!MONTH}"
  			hyprctl hyprpaper unload
  			exit 0
  			;;
  		"none+i3")
  			${getExe pkgs.feh} --bg-scale "''${!MONTH}"
  			;;
  	esac

  	echo "Set wallpaper: ''${MONTH} for desktop: ''${XDG_CURRENT_DESKTOP}"
''
