### Apps

stow
rofi-wayland

## font installation
1. use font_install.sh to install CodeNewRoman (already present in the dotfiles)
```
./font_install.sh
```


# starship prompt
https://starship.rs/guide/
```
curl -sS https://starship.rs/install.sh | sh
```
Add to ~/.bashrc
```
eval "$(starship init bash)"
```
Change the prompt
```
starship preset bracketed-segments -o ~/.config/starship.toml
```


1. kitty
2. tmux.
3. neovim.

### Prerequisites
fzf
fd
ripgrep
