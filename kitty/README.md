
## Installation

Run the following command to install/update kitty.
```
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
```
The binaries will be installed in the standard location for your OS, /Applications/kitty.app on macOS and ~/.local/kitty.app on Linux. The installer only touches files in that directory. To update kitty, simply re-run the command.

## Setup

### Desktop integration on Linux

```
# Create symbolic links to add kitty and kitten to PATH (assuming ~/.local/bin is in your system-wide PATH)
ln -sf ~/.local/kitty.app/bin/kitty ~/.local/kitty.app/bin/kitten ~/.local/bin/

# Place the kitty.desktop file somewhere it can be found by the OS
cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/

# If you want to open text files and images in kitty via your file manager also add the kitty-open.desktop file
# Only use if you want to change the default app to open
cp ~/.local/kitty.app/share/applications/kitty-open.desktop ~/.local/share/applications/

# Update the paths to the kitty and its icon in the kitty desktop file(s)
sed -i "s|Icon=kitty|Icon=$(readlink -f ~)/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty*.desktop
sed -i "s|Exec=kitty|Exec=$(readlink -f ~)/.local/kitty.app/bin/kitty|g" ~/.local/share/applications/kitty*.desktop

# Make xdg-terminal-exec (and hence desktop environments that support it use kitty)
echo 'kitty.desktop' > ~/.config/xdg-terminals.list
```

1. Open Kitty as maximized. Create a shortcut with the following command
```
kitty --start-as maximized
```

### Config

Help: https://sw.kovidgoyal.net/kitty/conf/

1. Update font family
```
font_family      CodeNewRoman
```
2. Hide window decorations. Remove the title bar (min, max, close buttons
```
hide_window_decorations yes
```

### Themes

Help: https://sw.kovidgoyal.net/kitty/kittens/themes/
```
kitten themes Tokyo Night Moon
```

