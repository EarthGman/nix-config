# a bunch of misc scripts for home-manager
{ pkgs, lib, config, ... }:
let
  inherit (lib) getExe;
  inherit (pkgs) writeScript;

  screenshot_timestamp = "$(date +%F_%T)";
  screenshot_output = "${config.home.homeDirectory}/Pictures/Screenshots/Screenshot-${screenshot_timestamp}.png";
in
{
  polybar = writeScript "polybar.sh" ''
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

  take_screenshot_selection_xorg = writeScript "take-screenshot-selection-xorg.sh" ''
      output="${screenshot_output}"
      if [ ! -d ${config.home.homeDirectory}/Pictures/Screenshots ]; then
        mkdir -p ${config.home.homeDirectory}/Pictures/Screenshots
      fi

      ${getExe pkgs.maim} -s | ${getExe pkgs.xclip} -selection clipboard -t image/png
      ${getExe pkgs.xclip} -selection clipboard -t image/png -o > $output

    if [ -s $output ]; then
      dunstify 'Screenshot saved to ~/Pictures/Screenshots'
    else
      rm $output
    fi
  '';

  take_screenshot_xorg = writeScript "take_screenshot_xorg.sh" ''
    output="${screenshot_output}"

    if [ ! -d ${config.home.homeDirectory}/Pictures/Screenshots ]; then
      mkdir -p ${config.home.homeDirectory}/Pictures/Screenshots
    fi

    if ${getExe pkgs.maim} | ${getExe pkgs.xclip} -selection clipboard -t image/png; ${getExe pkgs.xclip} -selection clipboard -t image/png -o > $output; then
      dunstify 'Screenshot saved to ~/Pictures/Screenshots'
    fi
  '';

  take_screenshot_window_xorg = writeScript "take_screenshot_window_xorg.sh" ''
    output="${screenshot_output}"

    if [ ! -d ${config.home.homeDirectory}/Pictures/Screenshots ]; then
      mkdir -p ${config.home.homeDirectory}/Pictures/Screenshots
    fi

    if ${getExe pkgs.maim} -i $(${getExe pkgs.xdotool} getactivewindow) | ${getExe pkgs.xclip} -selection clipboard -t image/png; ${getExe pkgs.xclip} -selection clipboard -t image/png -o > $output; then
      dunstify 'Screenshot saved to ~/Pictures/Screenshots'
    fi
  '';

  take_screenshot_selection_wayland = writeScript "take-screenshot-selection-wayland.sh" ''
    if [ ! -d ${config.home.homeDirectory}/Pictures/Screenshots ]; then
      mkdir -p ${config.home.homeDirectory}/Pictures/Screenshots
    fi
    timestamp=$(date +%F_%T)
    output="${config.home.homeDirectory}/Pictures/Screenshots/Screenshot-''${timestamp}.png"

    if selection=$(${getExe pkgs.slurp}) && ${getExe pkgs.grim} -g "$selection" - | ${pkgs.wl-clipboard}/bin/wl-copy; then
      ${pkgs.wl-clipboard}/bin/wl-paste > "$output"
      dunstify 'Screenshot saved to ~/Pictures/Screenshots'
    fi
  '';

  take_screenshot_wayland = writeScript "take-screenshot-wayland.sh" ''
    if [ ! -d ${config.home.homeDirectory}/Pictures/Screenshots ]; then
      mkdir -p ${config.home.homeDirectory}/Pictures/Screenshots
    fi
    timestamp=$(date +%F_%T)
    output="${config.home.homeDirectory}/Pictures/Screenshots/Screenshot-''${timestamp}.png"
    
    if ${getExe pkgs.grim} - | ${pkgs.wl-clipboard}/bin/wl-copy; then
      ${pkgs.wl-clipboard}/bin/wl-paste > "$output"
      dunstify 'Screenshot saved to ~/Pictures/Screenshots'
    fi
  '';

  wayland_wallpaper_switcher = writeScript "wayland-wallpaper-switcher.sh" ''
     WALLPAPERS="$(realpath ${config.home.homeDirectory}/Pictures/wallpapers)"

     case "$XDG_CURRENT_DESKTOP" in
     "sway")
       focused_monitor=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused).name')
       ;;
    "Hyprland")
       focused_monitor=$(hyprctl monitors | /run/current-system/sw/bin/awk '/^Monitor/{name=$2} /focused: yes/{print name}')
       ;;
    *)
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

