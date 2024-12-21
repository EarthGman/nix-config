{ pkgs, config, fetchurl, wallpapers, ... }:
pkgs.writeScript "omori-calendar-project.sh" ''
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

  if [ -n "$WAYLAND_DISPLAY" ]; then
  	swww img "''${!MONTH}"
  else
    feh --no-fehbg --bg-${config.services.fehbg.settings.scale-mode} "''${!MONTH}"
  fi

  echo "Set wallpaper: ''${MONTH} for desktop: ''${XDG_CURRENT_DESKTOP}"  
''
