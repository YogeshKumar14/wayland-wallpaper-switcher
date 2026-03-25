# Wayland Wallpaper Switcher (WWS)
Wayland Wallpaper Switcher is a streamlined utility designed for Wayland-based Linux systems. It leverages [awww](https://codeberg.org/LGFae/awww) to handle wallpaper transitions and wallust to dynamically generate system-wide color themes based on your active wallpaper, all accessible via a convenient Rofi menu.

### Images
<img width="1366" height="768" alt="2026-03-25-210953_hyprshot" src="https://github.com/user-attachments/assets/05442f95-0bff-4686-baef-602d2d458745" />
<img width="1366" height="768" alt="2026-03-25-210958_hyprshot" src="https://github.com/user-attachments/assets/bd453ebe-f616-4ba3-af37-39c14092b007" />
<img width="1366" height="768" alt="2026-03-25-211207_hyprshot" src="https://github.com/user-attachments/assets/a7aa1696-66e6-4543-b6d2-f45c62c010ba" />


 ## 🚀Features
 - **Dynamic Theming:** Automatically updates system colors using `wallust`.
 - **Smooth Transitions:** Uses `awww` for high-performance wallpaper switching.
 - **Rofi Integration:** A clean, searchable menu for picking your next look.
 - **Lightweight:** Built with simple shell scripts for minimal overhead.
## 📋Dependencies
Before installation, ensure you have the following tools installed on your system:

- [awww](https://codeberg.org/LGFae/awww) (Wallpaper daemon)

- wallust (Color palette generator)

- [rofi-wayland](https://github.com/in0ni/rofi-wayland) (The menu interface)


### Install using `pacman` and `yay`:

```bash
sudo pacman -Syu rofi-wayland awww
yay -S wallust-git
```

## 🛠️Installation
### 1. Clone the repository.
```ruby
cd $HOME
git clone https://github.com/YogeshKumar14/wayland-wallpaper-switcher.git
cd wayland-wallpaper-switcher
```
### 2. Setup the Script
Copy the scripts folder to your preferred location and make the main script executable:

```ruby
# Example: Moving to ~/.local/bin
mkdir -p ~/.local/bin
cp scripts/WallpaperSelect.sh ~/.local/bin/
chmod +x ~/.local/bin/WallpaperSelect.sh
```
### 3. Copy Configuration Files
Copy the folders called **rofi** and **wallust** into your `.config` folder.

```ruby
cp -r rofi wallust ~/.config/
```
### 4. Configuration
Open your `WallpaperSelect.sh` to update path to your wallpaper collection
```ruby
nano ~/.local/bin/WallpaperSelect.sh
```
For example:
```ruby
# WALLPAPERS PATH
wallDIR="$HOME/Pictures/Wallpapers"
```

You can also tweak the transition here:

```ruby
# awww transition config
FPS=60
TYPE="grow"
DURATION=2
AWWW_PARAMS="--transition-fps $FPS --transition-type $TYPE --transition-duration $DURATION"
```
## 🖥️Usage (Hyprland Integration)
Edit your `hyprland.conf` and add these lines.
```ruby
nano $HOME/.config/hypr/hyprland.conf
```
1. Define path variable```$wallpaper```

```ini
$wallpaper = $HOME/.local/bin/WallpaperSelect.sh
```

2. Bind a key
```ini
bind = $mainMod, W, exec, $wallpaper
```
Then save and quit using `CTRL + O`, `CTRL+X`

## Contributing

Pull requests are welcome. For major changes, please open an issue first
to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License

[MIT](https://choosealicense.com/licenses/mit/)
