# a bunch of misc scripts for home-manager
{ pkgs, lib, config, ... }:
let
  inherit (lib) getExe;
  inherit (pkgs) writeShellScript;
in
{
  polybar = writeShellScript "polybar.sh" ''
    ${getExe pkgs.killall} polybar
    sleep 0.1
    if type "xrandr"; then
      for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        MONITOR=$m ${getExe pkgs.polybar} --reload bottom &
      done
    else
      ${getExe pkgs.polybar} --reload bottom &
    fi 
  '';

  take_screenshot_xorg = writeShellScript "take_screenshot_xorg.sh" ''
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
  '';

  take_screenshot_wayland = writeShellScript "take-screenshot-wayland.sh" ''
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
      ${pkgs.libnotify}/bin/notify-send "Screenshot saved to ~/Pictures/screenshots
    ''${timestamp}.png"
      exit 0
    fi
    exit 1
  '';

  wayland_wallpaper_switcher = writeShellScript "wayland-wallpaper-switcher.sh" ''
     WALLPAPERS="$(realpath ${config.home.homeDirectory}/Pictures/wallpapers)"

     case "$XDG_CURRENT_DESKTOP" in
     "sway:wlroots")
       focused_monitor=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused).name')
       ;;
     "Hyprland")
       focused_monitor=$(hyprctl monitors | ${pkgs.gawk}/bin/awk '/^Monitor/{name=$2} /focused: yes/{print name}')
       ;;
     *)
       echo "no desktop detected"
       exit 1
       ;;
     esac
         												
     mapfile -d "" PICS < <(find "''${WALLPAPERS}" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" -o -iname "*.gif" \) -print0)

     rofi_command="rofi -i -show -dmenu -config ${config.xdg.configHome}/rofi/wallpapers.rasi"


     menu() {
       # Sort the PICS array
       IFS=$'\n' sorted_options=($(sort <<<"''${PICS[*]}"))

       # Place ". random" at the beginning with the random picture as an icon

       for pic_path in "''${sorted_options[@]}"; do
         pic_name=$(basename "$pic_path")

         # Displaying .gif to indicate animated images
         if [[ ! "$pic_name" =~ \.gif$ ]]; then
           printf "%s\x00icon\x1f%s\n" "$(echo "$pic_name" | cut -d. -f1)" "$pic_path"
         else
           printf "%s\n" "$pic_name"
         fi
       done
     }

     main() {
       choice=$(menu | $rofi_command)
       choice=$(echo "$choice" | xargs)

       if [[ -z "$choice" ]]; then
         exit 0
       fi

       pic_index=-1
       for i in "''${!PICS[@]}"; do
         filename=$(basename "''${PICS[$i]}")
         if [[ "$filename" == "$choice"* ]]; then
           pic_index=$i
           break
         fi
       done

       if [[ $pic_index -ne -1 ]]; then
         swww img -o "$focused_monitor" "''${PICS[$pic_index]}"
       else
         exit 1
       fi
    }

    if pidof rofi > /dev/null; then
      pkill rofi
    fi
     
    main
  '';
}
