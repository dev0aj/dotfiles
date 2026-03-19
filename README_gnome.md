1. Clone dotfiles
```
git clone https://github.com/dev0aj/dotfiles
```

2. Change default shell to bash
```
./scripts/change_shell.sh
```

3. Setup nerd font
```
./scripts/font_install.sh
```

4. Install & Setup starship prompt
```
./scripts/starship_setup.sh
```

5. Install packages (stow, kitty, neovim, tmux, tealdeer). The script uses pacman for installation. For other distro/package managers, install manually.
```
./scripts/packages_pacman.sh
```

## install dependencies

-- neovim

https://github.com/tree-sitter/tree-sitter/blob/master/crates/cli/README.md

```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
cargo install --locked tree-sitter-cli
```

-- tmux
1. tpm
```
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

