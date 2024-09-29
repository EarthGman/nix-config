{ pkgs, config, ... }:
pkgs.writeScript "wp-selector.sh" ''
  WALLPAPERS_DIR="${config.services.hyprpaper.sourceDirectory}"
  if [ ! -d "$WALLPAPERS_DIR"]; then
    echo "directory not found"
    exit 1
  fi

  wallpapers=$(ls "$WALLPAPERS_DIR" | grep -E "\.(jpg|jpeg|png|bmp|gif|webp)$")

  if [ -z "$wallpapers" ]; then
    echo "No wallpapers found"
    exit 1
  fi

  selected_wallpaper=$(echo "$wallpapers" | rofi -dmenu -i -p "Search")

  if [ -z "$selected_wallpaper" ]; then
    exit 0
  fi

  hyprctl hyprpaper preload "$WALLPAPERS_DIR/$selected_wallpaper"
  hyprctl hyprpaper wallpaper ",$WALLPAPERS_DIR/$selected_wallpaper"
''
