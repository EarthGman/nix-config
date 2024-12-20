{ pkgs, config, fetchurl, wallpapers, getExe, ... }:
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
      "none+i3")
        ${getExe pkgs.feh} --bg-scale "''${!MONTH}"
        ;;
      "sway")
        swww img --resize crop "''${!MONTH}"
        ;;
      "Hyprland")
        swww img --resize crop "''${!MONTH}"
        ;;
    esac

    echo "Set wallpaper: ''${MONTH} for desktop: ''${XDG_CURRENT_DESKTOP}"  
''
