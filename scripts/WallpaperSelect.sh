#!/bin/bash

# WALLPAPERS PATH
wallDIR="$HOME/Pictures/Wallpapers"

# Variables
focused_monitor=$(hyprctl monitors | awk '/^Monitor/{name=$2} /focused: yes/{print name}')


# swww transition config
FPS=60
TYPE="grow"
DURATION=2
AWWW_PARAMS="--transition-fps $FPS --transition-type $TYPE --transition-duration $DURATION"

# Check if swaybg is running
if pidof swaybg >/dev/null; then
  pkill swaybg
fi


# Retrieve image files
mapfile -d '' PICS < <(find "${wallDIR}" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \) -print0)

RANDOM_PIC="${PICS[$((RANDOM % ${#PICS[@]}))]}"
RANDOM_PIC_NAME=". random"

# Rofi command
rofi_command="rofi -i -show -dmenu -config ~/.config/rofi/config-wallpaper.rasi"

# Sorting Wallpapers for Menu
menu() {
  IFS=$'\n' sorted_options=($(sort <<<"${PICS[*]}"))

  # Random option
  printf "%s\x00icon\x1f%s\n" "$RANDOM_PIC_NAME" "$RANDOM_PIC"

  for pic_path in "${sorted_options[@]}"; do
    pic_name=$(basename "$pic_path")
    # Display name without extension (except for gifs)
    if [[ ! "$pic_name" =~ \.gif$ ]]; then
      printf "%s\x00icon\x1f%s\n" "$(echo "$pic_name" | cut -d. -f1)" "$pic_path"
    else
      printf "%s\x00icon\x1f%s\n" "$pic_name" "$pic_path"
    fi
  done
}

# Initiate swww if not running
awww query || awww-daemon --format xrgb

main() {
  choice=$(menu | $rofi_command)
  choice=$(echo "$choice" | xargs)
  RANDOM_PIC_NAME=$(echo "$RANDOM_PIC_NAME" | xargs)

  if [[ -z "$choice" ]]; then
    exit 0
  fi

  # --- Handle Selection ---
  target_pic=""

  if [[ "$choice" == "$RANDOM_PIC_NAME" ]]; then
    target_pic="$RANDOM_PIC"
  else
    # Find the full path for the specific choice
    for pic in "${PICS[@]}"; do
      filename=$(basename "$pic")
      if [[ "$filename" == "$choice"* ]]; then
        target_pic="$pic"
        break
      fi
    done
  fi

  if [[ -n "$target_pic" ]]; then
    # 1. Set Wallpaper
    if pidof waybar >/dev/null; then
      pkill waybar
    fi
    awww img -o "$focused_monitor" "$target_pic" $AWWW_PARAMS
    
    # 2. Run Wallust (wallust run /path/to/img)
    wallust run "$target_pic"
    
    # 3. Reload Hyprland to apply new colors (Optional but recommended)
    hyprctl reload

    waybar & disown
  else
    echo "Image not found."
    exit 1
  fi
}

# Kill existing rofi instance if running
if pidof rofi >/dev/null; then
  pkill rofi
  sleep 0.2
fi

main
