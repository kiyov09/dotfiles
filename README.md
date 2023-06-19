# Dotfiles

## Follow steps from [here](https://gist.github.com/kamermanpr/23bc20180dc277bc8043558f0c22f8a9) first to set up:

1. xcode dev tools
2. Homebrew
3. Git

## Config ssh for github

## Clone the dotfiles repo from github.com/kiyov09/dotfiles

## Zsh

1. Install oh-my-zsh

```bash
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

2. Symlink .zshrc

3. Install plugins
   - zsh-completions
   - zsh-syntax-highlighting
   - zsh-autosuggestions

## Wezterm

1. Follow instructions for instalation from [here](https://wezfurlong.org/wezterm/install/macos.html).
2. Install [SF-Mono-Nerd-Font](https://github.com/epk/SF-Mono-Nerd-Font).
3. Symlink the config folder to HOME.

## Neovim

1. Install neovim.

```bash
brew install neovim
```

2. Install python3 and the neovim module

```bash
brew install python
pip3 install neovim
```

3. Install packer. See [here](https://github.com/wbthomason/packer.nvim#quickstart)
4. Open neovim (there is an alias in the zshrc to open it as vim) and run
   :PackerInstall

## Tmux

1. Install tmux

```bash
brew install tmux
```

2. Symlink files
3. Clone the tpm

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

4. Open tmux and install all plugins (prefix + I)

## Required packages

- oh-my-zsh
- tmux
- neovim
- wezterm
- karabiner-elements
- bat
- gh (github cli)
- chrome-cli
- node
- rustup
- fzf
- ripgrep
- jq
- tldr
- httpie

> Note: See the brew-dump.txt file for more

## Apps

- Chrome
- Alfred
- Hammerspoon
- Karabiner-Elements
- Better touch tools
- Dash
