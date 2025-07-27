{ pkgs, config, ... }:
pkgs.writeShellScript "rofi-wallpaper-switcher" ''
   WALLPAPERS="$(realpath ${config.home.homeDirectory}/Pictures/wallpapers)"

   case "$XDG_CURRENT_DESKTOP" in
   *"sway"*)
     focused_monitor=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused).name')
     ;;
   *"Hyprland"*)
     focused_monitor=$(hyprctl monitors | ${pkgs.gawk}/bin/awk '/^Monitor/{name=$2} /focused: yes/{print name}')
     ;;
   *)
     echo "unsupported desktop environment"
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
''
